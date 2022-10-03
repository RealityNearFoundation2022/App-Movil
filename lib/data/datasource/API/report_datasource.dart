import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/models/reportModel.dart';
import 'package:http/http.dart' as http;

abstract class ReportsRemoteDataSource {
  Future<bool> createReport(ReportModel report);
}

class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  final String baseUrl = API_REALITY_NEAR + "reports/";
  var log = Logger();

  ReportsRemoteDataSourceImpl();

  @override
  Future<bool> createReport(ReportModel report) async {
    final url = baseUrl;
    var body = report.toJson();
    var bodyData = json.encode(body);
    String token = await getPersistData("userToken");
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
}
