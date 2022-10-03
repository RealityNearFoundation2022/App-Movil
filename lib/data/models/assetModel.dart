// To parse this JSON data, do
//
//     final assetModel = assetModelFromJson(jsonString);

import 'dart:convert';

AssetModel assetModelFromJson(String str) => AssetModel.fromJson(json.decode(str));

String assetModelToJson(AssetModel data) => json.encode(data.toJson());

class AssetModel {
  AssetModel({
    this.name,
    this.path,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  final String name;
  final String path;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
    name: json["name"],
    path: json["path"],
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "path": path,
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
