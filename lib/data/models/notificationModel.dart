import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:reality_near/domain/entities/user.dart';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel(
      {@required this.type,
      @required this.read,
      @required this.data,
      @required this.id,
      @required this.ownerId});

  final String type;
  final int read;
  final Data data;
  final int id;
  final int ownerId;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        type: json["type"],
        read: json["read"],
        data: Data.fromJson(json["data"]),
        id: json["id"],
        ownerId: json["owner_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "read": read,
        "data": data.toJson(),
        "id": id,
        "owner_id": ownerId,
      };
}

class Data {
  Data({@required this.contactId, @required this.username, this.userPhoto});

  final int contactId;
  final String username;
  final String userPhoto;
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        contactId: json["contact_id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "contact_id": contactId,
        "username": username,
      };
}
