import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:http/http.dart' as http;
import 'package:reality_near/data/models/cuponAssignModel.dart';
import 'package:reality_near/data/models/cuponModel.dart';

abstract class CuponRemoteDataSource {
  Future<String> AssignCuponToUser(String cuponId);
  Future<List<AssignCuponModel>> ReadCuponFromUser();
  Future<CuponModel> ReadCupon(String cuponId);
  Future<AssignCuponModel> RedeemCupon(String cuponId,String ownerId);
}

class CuponRemoteDataSourceImpl extends CuponRemoteDataSource{
  final String baseUrl = API_REALITY_NEAR + "coupons/";
  var log = Logger();

  @override
  Future<String> AssignCuponToUser(String cuponId) async {
    final url = baseUrl+"assign/"+cuponId;
    String token = await getPersistData("userToken");
    print('URL: $url');
    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        });

    //PARA VERIFICAR
    print('respuesta assignCuponToUser: '+response.body);
    log.i(response.statusCode);
    log.i(response.body);
    if (response.statusCode == 200) {
      bool redeemed = json.decode(response.body)["redeemed"];
      return "Cupón asignado";
    } if (response.statusCode == 404) {
      return json.decode(response.body)["detail"];
    }else {
      throw ServerException();
    }
  }

  @override
  Future<List<AssignCuponModel>> ReadCuponFromUser() async {
    final url = baseUrl+"assign";
    String token = await getPersistData("userToken");
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    String body = utf8.decode(response.bodyBytes);
    //PARA VERIFICAR
    log.i(response.body);
    log.i(response.statusCode);
    //si es cod200 devolvemos obj si no lanzamos excepcion
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => AssignCuponModel.fromJson(i))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CuponModel> ReadCupon(String cuponId) async {
    String url = API_REALITY_NEAR + "coupons/$cuponId";
    String token = await getPersistData("userToken");
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json; charset=UTF-8",
        "Authorization": "Bearer $token",
      },
    );
    //PARA VERIFICAR
    log.i(response.body);
    log.i(response.statusCode);
    //si es cod200 devolvemos obj si no lanzamos excepcion
    if (response.statusCode == 200) {
      return CuponModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AssignCuponModel> RedeemCupon(String cuponId,String ownerId) async{
    String url = API_REALITY_NEAR + "coupons/redeem/$ownerId/$cuponId";
    String token = await getPersistData("userToken");
    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    //PARA VERIFICAR
    log.i(response.body);
    log.i(response.statusCode);
    //si es cod200 devolvemos obj si no lanzamos excepcion
    if (response.statusCode == 200) {
      return AssignCuponModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

}