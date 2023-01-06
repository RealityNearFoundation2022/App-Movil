import 'dart:convert';

import 'package:latlong2/latlong.dart';

AssetModel assetModelFromJson(String str) =>
    AssetModel.fromJson(json.decode(str));

String assetModelToJson(AssetModel data) => json.encode(data.toJson());

class AssetModel {
  AssetModel({
    this.name,
    this.locations,
    this.id,
    this.path,
    this.createdAt,
    this.updatedAt,
  });

  final String name;
  final List<LatLng> locations;
  final int id;
  final String path;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
        name: json["name"],
        locations:
            List<LatLng>.from(json["locations"].map((x) => LatLng(x[0], x[1]))),
        id: json["id"],
        path: json["path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "locations": List<dynamic>.from(locations.map((x) => x)),
        "id": id,
        "path": path,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
