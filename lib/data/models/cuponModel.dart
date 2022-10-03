import 'package:meta/meta.dart';
import 'dart:convert';

CuponModel cuponModelFromJson(String str) => CuponModel.fromJson(json.decode(str));

String cuponModelToJson(CuponModel data) => json.encode(data.toJson());

class CuponModel {
  CuponModel({
    @required this.assetId,
    @required this.name,
    @required this.title,
    @required this.description,
    @required this.terms,
    @required this.quantity,
    @required this.expiration,
    @required this.id,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.asset,
  });

  int assetId;
  String name;
  String title;
  String description;
  String terms;
  int quantity;
  DateTime expiration;
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  Asset asset;

  factory CuponModel.fromJson(Map<String, dynamic> json) => CuponModel(
    assetId: json["asset_id"],
    name: json["name"],
    title: json["title"],
    description: json["description"],
    terms: json["terms"],
    quantity: json["quantity"],
    expiration: DateTime.parse(json["expiration"]),
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    asset: Asset.fromJson(json["asset"]),
  );

  Map<String, dynamic> toJson() => {
    "asset_id": assetId,
    "name": name,
    "title": title,
    "description": description,
    "terms": terms,
    "quantity": quantity,
    "expiration": expiration.toIso8601String(),
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "asset": asset.toJson(),
  };
}

class Asset {
  Asset({
    @required this.name,
    @required this.createdAt,
    @required this.id,
    @required this.path,
    @required this.updatedAt,
  });

  String name;
  DateTime createdAt;
  int id;
  String path;
  DateTime updatedAt;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
    path: json["path"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "id": id,
    "path": path,
    "updated_at": updatedAt.toIso8601String(),
  };
}
