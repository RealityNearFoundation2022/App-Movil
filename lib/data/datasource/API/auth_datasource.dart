import 'dart:convert';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/models/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class AuthsRemoteDataSource {
  Future<UserModel> registerNewUserWithEmail(
      String email, String password, String username, String path);

  Future<bool> loginWithEmail(String email, String password);
}

class AuthsRemoteDataSourceImpl implements AuthsRemoteDataSource {
  final String baseUrl = API_REALITY_NEAR + "users/";
  var log = Logger();

  AuthsRemoteDataSourceImpl();

  @override
  Future<UserModel> registerNewUserWithEmail(
      String email, String password, String username, String path) async {
    final url = baseUrl + "open";
    Map data = {
      "email": email,
      "password": password,
      "full_name": username,
      "avatar": path,
    };
    var bodyData = json.encode(data);

    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: bodyData);

    //PARA VERIFICAR
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> loginWithEmail(String email, String password) async {
    String url = API_REALITY_NEAR + "login/access-token";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "username": email,
        "password": password,
      },
    );
    String body = utf8.decode(response.bodyBytes);
    final jsonData = jsonDecode(body);
    String token = jsonData["access_token"];
    print('token: $token');
    log.i(response.body);
    log.i(response.statusCode);
    response.statusCode == 200 ? {persistData('userToken', token)} : null;
    return response.statusCode == 200 ? true : false;
  }
}
