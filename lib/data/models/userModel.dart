// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:reality_near/domain/entities/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  UserModel({
    this.email,
    this.isActive,
    this.isSuperuser,
    this.fullName,
    this.path,
    this.avatar,
    this.id,
    this.createdAt,
    this.updatedAt,
  }) : super(
          email: email,
          isActive: isActive,
          isSuperuser: isSuperuser,
          fullName: fullName,
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          avatar: avatar,
          path: path
        );

  final String email;
  final bool isActive;
  final bool isSuperuser;
  final String fullName;
  final String path;
  final String avatar;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    isActive: json["is_active"],
    isSuperuser: json["is_superuser"],
    fullName: json["full_name"],
    path: json["path"],
    avatar: json["avatar"],
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "is_active": isActive,
    "is_superuser": isSuperuser,
    "full_name": fullName,
    "path": path,
    "avatar": avatar,
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
