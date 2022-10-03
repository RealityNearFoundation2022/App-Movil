import 'dart:convert';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:reality_near/data/models/assetModel.dart';
import 'package:reality_near/data/models/notificationModel.dart';

abstract class AssetRemoteDataSource {
  Future<AssetModel> getAsset(String id);
}

class AssetRemoteDataSourceImpl implements AssetRemoteDataSource {
  final String baseUrl = API_REALITY_NEAR + "assets";
  var log = Logger();

  AssetRemoteDataSourceImpl();

  @override
  Future<AssetModel> getAsset(String id) async {
    final url = baseUrl+"/$id";
    String token = await getPersistData("userToken");

    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    //PARA VERIFICAR
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200) {
      return AssetModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

}
