import 'dart:convert';

import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/models/userModel.dart';
import 'package:http/http.dart' as http;

abstract class AuthsRemoteDataSource {
  Future<UserModel> registerNewUserWithEmail(
      String email, String password, String username);
}

class AuthsRemoteDataSourceImpl implements AuthsRemoteDataSource {
  final String baseUrl = API_REALITY_NEAR + "users/";

  AuthsRemoteDataSourceImpl();

  @override
  Future<UserModel> registerNewUserWithEmail(
      String email, String password, String username) async {
    final url = baseUrl + "open";
    Map data = {
      "email": email,
      "password": password,
      "full_name": username,
    };
    var bodyData = json.encode(data);

    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: bodyData);

    //PARA VERIFICAR
    print('Response status: ${response.statusCode} body: ${response.body}');
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
