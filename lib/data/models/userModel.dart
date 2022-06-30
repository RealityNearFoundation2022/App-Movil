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
    this.id,
  }) : super(
          email: email,
          isActive: isActive,
          isSuperuser: isSuperuser,
          fullName: fullName,
          id: id,
        );

  final String email;
  final bool isActive;
  final bool isSuperuser;
  final String fullName;
  final int id;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        isActive: json["is_active"],
        isSuperuser: json["is_superuser"],
        fullName: json["full_name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "is_active": isActive,
        "is_superuser": isSuperuser,
        "full_name": fullName,
        "id": id,
      };
}
