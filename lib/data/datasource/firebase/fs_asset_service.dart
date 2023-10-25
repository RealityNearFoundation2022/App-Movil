import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:reality_near/data/models/asset_model.dart';
import 'package:reality_near/data/models/cuponModel.dart';

abstract class FsAssetService {
  Future<AssetModel> getAsset(String id);
  Future<List<AssetModel>> getAllAssets();
}

class AssetRemoteDataSourceImpl implements FsAssetService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String col_asset = "assets";
  final String col_location = "locations";
  final String col_cupon = "cupons";
  var log = Logger();

  AssetRemoteDataSourceImpl();

  @override
  Future<AssetModel> getAsset(String id) async {
    try {
      // Obtén el documento de activos (assets)
      DocumentSnapshot assetDoc =
          await firestore.collection(col_asset).doc(id).get();

      if (assetDoc.exists) {
        final Map<String, dynamic> assetData =
            assetDoc.data() as Map<String, dynamic>;

        // Obtén la subcolección de ubicaciones (locations) dentro del documento de activos (assets)
        QuerySnapshot locationsDoc = await firestore
            .collection(col_asset)
            .doc(id)
            .collection(col_location)
            .get();
        final List<Location> locations = locationsDoc.docs.map((locationDoc) {
          final Map<String, dynamic> locationData =
              locationDoc.data() as Map<String, dynamic>;
          var loc = Location.fromMap(locationData);
          loc.id = locationDoc.id;
          return loc;
        }).toList();

        // Obtén la subcolección de cupones (cupons) dentro del documento de activos (assets)
        QuerySnapshot cuponsDoc = await firestore
            .collection(col_asset)
            .doc(id)
            .collection(col_cupon)
            .get();
        final List<CuponModel> cupons = cuponsDoc.docs.map((cuponDoc) {
          final Map<String, dynamic> cuponData =
              cuponDoc.data() as Map<String, dynamic>;
          var cupon = CuponModel.fromMap(cuponData);
          cupon.id = cuponDoc.id;
          return cupon;
        }).toList();
        // Crea un objeto AssetModel utilizando el método fromMap
        final asset = AssetModel.fromMap(assetData);
        asset.locations = locations;
        asset.cupons = cupons;

        return asset;
      } else {
        // Manejar el caso en el que el documento de activos no existe
        return null;
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<AssetModel>> getAllAssets() async {
    try {
      QuerySnapshot assetDocs = await firestore.collection(col_asset).get();

      final List<Future<AssetModel>> assetFutures =
          assetDocs.docs.map((assetDoc) async {
        final Map<String, dynamic> assetData =
            assetDoc.data() as Map<String, dynamic>;

        // Obtén la subcolección de ubicaciones (locations) dentro del documento de activos (assets)
        QuerySnapshot locationsDoc =
            await assetDoc.reference.collection(col_location).get();
        final List<Location> locations = locationsDoc.docs.map((locationDoc) {
          final Map<String, dynamic> locationData =
              locationDoc.data() as Map<String, dynamic>;
          var loc = Location.fromMap(locationData);
          loc.id = locationDoc.id;
          return loc;
        }).toList();

        // Obtén la subcolección de cupones (cupons) dentro del documento de activos (assets)
        QuerySnapshot cuponsDoc =
            await assetDoc.reference.collection(col_cupon).get();
        final List<CuponModel> cupons = cuponsDoc.docs.map((cuponDoc) {
          final Map<String, dynamic> cuponData =
              cuponDoc.data() as Map<String, dynamic>;
          var cupon = CuponModel.fromMap(cuponData);
          cupon.id = cuponDoc.id;
          return cupon;
        }).toList();
        // Crea un objeto AssetModel utilizando el método fromMap
        final asset = AssetModel.fromMap(assetData);
        asset.locations = locations;
        asset.cupons = cupons;

        return asset;
      }).toList();

      final List<AssetModel> assets = await Future.wait(assetFutures);

      return assets;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
