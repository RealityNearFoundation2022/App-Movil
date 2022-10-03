import 'dart:convert';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:reality_near/data/models/contactModel.dart';

abstract class ContactRemoteDataSource {
  Future<bool> addContact(String userId);
  Future<bool> acceptPendigRequest(String contactId);
  Future<bool> removeDeleteContacts(String contactId);
  Future<List<ContactModel>> getPendingContacts();
  Future<List<ContactModel>> getContacts();
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final String baseUrl = API_REALITY_NEAR + "contacts/";
  var log = Logger();

  ContactRemoteDataSourceImpl();
  @override
  addContact(String contactId) async {
    final url = baseUrl;
    String token = await getPersistData("userToken");

    Map data = {
      "contact_id": contactId,
    };
    var bodyData = json.encode(data);

    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: bodyData);

    //PARA VERIFICAR
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }
  @override
  getContacts() async {
    final url = baseUrl;
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
          .map((i) => ContactModel.fromJson(i))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  getPendingContacts() async {
    final url = baseUrl + "pending";
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
          .map((i) => ContactModel.fromJson(i))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  acceptPendigRequest(String contactId) async{
    final url = baseUrl + "$contactId/approved";
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
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  removeDeleteContacts(String contactId) async{
    final url = baseUrl + contactId;
    String token = await getPersistData("userToken");
    final response = await http.delete(
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
      return true;
    } else {
      throw ServerException();
    }
  }


}
