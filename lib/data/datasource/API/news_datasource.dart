import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/models/news_model.dart';
import 'package:http/http.dart' as http;

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews();
}

class NewsRemoteDataSourceImpl extends NewsRemoteDataSource {
  final String baseUrl = API_REALITY_NEAR + "news/";
  var log = Logger();

  @override
  Future<List<NewsModel>> getNews() async {
    final url = baseUrl;
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
    );
    String body = utf8.decode(response.bodyBytes);
    //PARA VERIFICAR
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200) {
      List<NewsModel> news = [];
      List<dynamic> newsJson = json.decode(response.body);
      for (var element in newsJson) {
        news.add(NewsModel.fromJson(element));
      }
      return news;
    } else {
      throw ServerException();
    }
  }
}
