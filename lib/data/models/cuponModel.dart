import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class CuponModel {
  CuponModel({
    @required this.name,
    @required this.title,
    @required this.description,
    @required this.terms,
    @required this.quantity,
    @required this.expiration,
    this.id,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.img,
  });

  final String name;
  final String title;
  final String description;
  final String terms;
  int quantity;
  String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime expiration;
  final String img;

  factory CuponModel.fromMap(Map<String, dynamic> data) {
    final dynamic updatedAtData = data['updated_at'];
    final dynamic createdAtData = data['created_at'];
    final dynamic expirationData = data['expiration'];

    DateTime expiration;
    DateTime createdAt;
    DateTime updatedAt;

    if (expirationData is Timestamp) {
      expiration = expirationData.toDate();
    } else if (expirationData is DateTime) {
      expiration = expirationData;
    }

    if (createdAtData is Timestamp) {
      createdAt = createdAtData.toDate();
    } else if (createdAtData is DateTime) {
      createdAt = createdAtData;
    }

    if (updatedAtData is Timestamp) {
      updatedAt = updatedAtData.toDate();
    } else if (updatedAtData is DateTime) {
      updatedAt = updatedAtData;
    }

    return CuponModel(
      img: data['img'],
      name: data['name'],
      title: data['title'],
      description: data['description'],
      terms: data['terms'],
      quantity: data['quantity'],
      id: data['id'] ?? '',
      expiration: expiration,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'description': description,
      'terms': terms,
      'quantity': quantity,
      'expiration': expiration,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'img': img,
      'id': id ?? ''
    };
  }

  //model to string
  String toJson(CuponModel data) {
    final Map<String, dynamic> cuponMap = data.toMap();

    // Convierte los objetos DateTime en sus representaciones String en formato ISO 8601
    cuponMap['createdAt'] = data.createdAt.toIso8601String();
    cuponMap['updatedAt'] = data.updatedAt.toIso8601String();
    cuponMap['expiration'] = data.expiration.toIso8601String();

    return json.encode(cuponMap);
  }

  //string to model
  CuponModel cuponFromJson(String str) {
    final Map<String, dynamic> jsonData = json.decode(str);

    // Convierte las representaciones en formato ISO 8601 de DateTime a objetos DateTime
    final createdAt = DateTime.parse(jsonData['createdAt']);
    final updatedAt = DateTime.parse(jsonData['updatedAt']);
    final expiration = DateTime.parse(jsonData['expiration']);

    jsonData['createdAt'] = createdAt;
    jsonData['updatedAt'] = updatedAt;
    jsonData['expiration'] = expiration;

    return CuponModel.fromMap(jsonData);
  }
}
