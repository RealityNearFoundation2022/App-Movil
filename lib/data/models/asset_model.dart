// To parse this JSON data, do
//
//     final AssetModel = AssetModelFromJson(jsonString);

import 'dart:convert';

import 'package:latlong2/latlong.dart';

AssetModel AssetModelFromJson(String str) =>
    AssetModel.fromJson(json.decode(str));

String AssetModelToJson(AssetModel data) => json.encode(data.toJson());

class AssetModel {
  AssetModel({
    this.name,
    this.locations,
    this.defaultAsset,
    this.id,
    this.path,
    this.path2,
    this.createdAt,
    this.updatedAt,
  });

  final String name;
  final List<Location> locations;
  final bool defaultAsset;
  final int id;
  final String path;
  final String path2;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
        name: json["name"],
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
        defaultAsset: json["default"],
        id: json["id"],
        path: json["path"],
        path2: json["path_2"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "default": defaultAsset,
        "id": id,
        "path": path,
        "path_2": path2,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Location {
  Location({
    this.id,
    this.position,
    this.assetId,
    this.rule,
  });

  final int id;
  final LatLng position;
  final int assetId;
  final String rule;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        position: LatLng(double.parse(json["lat"]), double.parse(json["lng"])),
        assetId: json["asset_id"],
        rule: json["rule"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lng": position.longitude,
        "asset_id": assetId,
        "lat": position.latitude,
        "rule": rule,
      };
}
