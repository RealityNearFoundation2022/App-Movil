import 'dart:convert';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:reality_near/data/models/asset_model.dart';

abstract class AssetRemoteDataSource {
  Future<AssetModel> getAsset(String id);
  Future<List<AssetModel>> getAllAssets();
  Future<bool> updateAsset(AssetModel asset);
  Future<bool> updateLocation(int assetID, Location location);
  Future<bool> addLocation(int assetID, Location location);
  Future<bool> deleteLocation(Location location);
}

class AssetRemoteDataSourceImpl implements AssetRemoteDataSource {
  final String baseUrl = API_REALITY_NEAR + "assets";
  final String assetLocarionUrl = API_REALITY_NEAR + "asset";
  var log = Logger();

  AssetRemoteDataSourceImpl();

  @override
  Future<AssetModel> getAsset(String id) async {
    final url = baseUrl + "/$id";
    String token = await getPreference("userToken");

    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200) {
      return AssetModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<AssetModel>> getAllAssets() async {
    final url = "$baseUrl/";
    String token = await getPreference("userToken");

    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    //PARA VERIFICAR

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      return list.map((e) => AssetModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateAsset(AssetModel asset) async {
    final url = baseUrl + "/${asset.id}";
    String token = await getPreference("userToken");

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var body = json.encode(asset.toJson());

    final response =
        await http.put(Uri.parse(url), headers: header, body: body);

    return response.statusCode == 200;
  }

  @override
  Future<bool> addLocation(int assetID, Location location) async {
    final url = assetLocarionUrl + "/$assetID/location";
    String token = await getPreference("userToken");

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var body = json.encode(location.toJson());

    final response =
        await http.post(Uri.parse(url), headers: header, body: body);

    return response.statusCode == 200;
  }

  @override
  Future<bool> deleteLocation(Location location) async {
    final url = assetLocarionUrl + "/${location.id}/location";
    String token = await getPreference("userToken");

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final response = await http.delete(Uri.parse(url), headers: header);

    return response.statusCode == 200;
  }

  @override
  Future<bool> updateLocation(int assetID, Location location) async {
    final url = assetLocarionUrl + "/${location.id}/location";
    String token = await getPreference("userToken");

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var body = json.encode(location.toJson());

    final response =
        await http.put(Uri.parse(url), headers: header, body: body);

    return response.statusCode == 200;
  }
}
