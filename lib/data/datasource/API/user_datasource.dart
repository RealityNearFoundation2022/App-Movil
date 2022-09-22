import 'dart:convert';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/models/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:reality_near/domain/entities/user.dart';

abstract class userRemoteDataSource {
  Future<UserModel> getMyData();
}

class userRemoteDataSourceImpl implements userRemoteDataSource {
  final String baseUrl = API_REALITY_NEAR + "users/";
  var log = Logger();

  userRemoteDataSourceImpl();

  @override
  Future<UserModel> getMyData() async {
    String url = API_REALITY_NEAR + "users/me";
    String token = await getPersistData("userToken");
    final response = await http.get(
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
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<User>> getUsers() async {
    String url = API_REALITY_NEAR + "users/?skip=0&limit=250";
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
          .map((i) => UserModel.fromJson(i))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<User> getUserById(String userId) async {
    String url = API_REALITY_NEAR + "users/${userId}";
    String token = await getPersistData("userToken");
    final response = await http.get(
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
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  editUserData(String avatar, String username, String password) async {
    String url = API_REALITY_NEAR + "users/me";
    String token = await getPersistData("userToken");

    Map data = {
      "full_name": username,
      if (password.isNotEmpty) "password": password,
      "avatar": avatar,
    };

    var bodyData = json.encode(data);

    final response = await http.put(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: bodyData);
    //PARA VERIFICAR
    log.i(response.body);
    log.i(response.statusCode);
  }
}
