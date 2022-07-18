import 'dart:convert';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class ContactRemoteDataSource {
  void addContact(String userId);
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final String baseUrl = API_REALITY_NEAR + "contacts/";
  var log = Logger();

  ContactRemoteDataSourceImpl();
  @override
  addContact(String contactId) async {
    final url = baseUrl;
    Map data = {
      "pending": 0,
      "contact_id": contactId,
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
  }
}
