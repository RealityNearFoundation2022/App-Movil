import 'dart:convert';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:reality_near/data/models/notificationModel.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<List<NotificationModel>> getNotificationsHis();
  readNotification(int notificationId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final String baseUrl = API_REALITY_NEAR + "notifications";
  var log = Logger();

  NotificationRemoteDataSourceImpl();

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final url = baseUrl+"/?skip=0&limit=100";
    String token = await getPersistData("userToken");

    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    //PARA VERIFICAR
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200) {
      List<NotificationModel> notificationList = [];
      List<dynamic> jsonList = json.decode(response.body);
      for (var item in jsonList) {
        notificationList.add(NotificationModel.fromJson(item));
      }
      return notificationList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<NotificationModel>> getNotificationsHis() async {
    final url = baseUrl + "/history"+"?skip=0&limit=100";
    String token = await getPersistData("userToken");

    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    //PARA VERIFICAR
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200) {
      List<NotificationModel> notificationList = [];
      List<dynamic> jsonList = json.decode(response.body);
      for (var item in jsonList) {
        notificationList.add(NotificationModel.fromJson(item));
      }
      return notificationList;
    } else {
      throw ServerException();
    }
  }

  @override
  readNotification(int notificationId) async {
    final url = baseUrl + "/$notificationId";
    String token = await getPersistData("userToken");

    final response = await http.put(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

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
