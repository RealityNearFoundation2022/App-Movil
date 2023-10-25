import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.email,
    this.isActive,
    this.isSuperuser,
    this.username,
    this.photoUrl,
    this.avatar,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  final String email;
  final bool isActive;
  final bool isSuperuser;
  final String username;
  final String photoUrl;
  final String avatar;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Método para crear una instancia del modelo de datos a partir de un DocumentSnapshot
  factory UserModel.fromMap(Map<String, dynamic> data) {
    final dynamic createdAtData = data['createdAt'];
    final dynamic updatedAtData = data['updatedAt'];

    DateTime createdAt;
    DateTime updatedAt;

    if (createdAtData is Timestamp) {
      createdAt = createdAtData.toDate();
    } else if (createdAtData is DateTime) {
      createdAt = createdAtData;
    } else {
      // Manejar otros casos si es necesario
      // Por ejemplo, puedes convertir una cadena a DateTime si es una representación válida de fecha
      // O establecerlo en DateTime.now() como valor predeterminado
    }

    if (updatedAtData is Timestamp) {
      updatedAt = updatedAtData.toDate();
    } else if (updatedAtData is DateTime) {
      updatedAt = updatedAtData;
    } else {
      // Manejar otros casos si es necesario
    }

    return UserModel(
      email: data['email'] ?? '',
      isActive: data['isActive'] ?? false,
      isSuperuser: data['isSuperuser'] ?? false,
      username: data['username'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      avatar: data['avatar'] ?? '',
      id: data['id'] ?? 0,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  // Método para convertir el modelo de datos a un mapa (para guardar en Firestore)
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'isActive': isActive,
      'isSuperuser': isSuperuser,
      'username': username,
      'photoUrl': photoUrl,
      'avatar': avatar,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  UserModel userModelFromJson(String str) {
    final Map<String, dynamic> jsonData = json.decode(str);

    // Convierte las representaciones en formato ISO 8601 de DateTime a objetos DateTime
    final createdAt = DateTime.parse(jsonData['createdAt']);
    final updatedAt = DateTime.parse(jsonData['updatedAt']);

    jsonData['createdAt'] = createdAt;
    jsonData['updatedAt'] = updatedAt;

    return UserModel.fromMap(jsonData);
  }

  String userModelToJson(UserModel data) {
    final Map<String, dynamic> userMap = data.toMap();

    // Convierte los objetos DateTime en sus representaciones String en formato ISO 8601
    userMap['createdAt'] = data.createdAt.toIso8601String();
    userMap['updatedAt'] = data.updatedAt.toIso8601String();

    return json.encode(userMap);
  }
}
