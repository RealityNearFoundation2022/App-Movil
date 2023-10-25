import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:reality_near/data/models/cuponModel.dart';

class AssetModel {
  AssetModel({
    this.name,
    this.locations,
    this.cupons,
    this.defaultAsset,
    this.id,
    this.pathAndroid,
    this.pathIos,
    this.updatedAt,
    this.createdAt,
    this.scaleX,
    this.scaleY,
    this.scaleZ,
    this.rotationX,
    this.rotationY,
    this.rotationZ,
    this.positionX,
    this.positionY,
    this.positionZ,
  });

  final String name;
  List<Location> locations;
  List<CuponModel> cupons;
  final bool defaultAsset;
  String id;
  String pathAndroid;
  String pathIos;
  final DateTime updatedAt;
  final DateTime createdAt;
  final double scaleX;
  final double scaleY;
  final double scaleZ;
  final double rotationX;
  final double rotationY;
  final double rotationZ;
  final double positionX;
  final double positionY;
  final double positionZ;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'defaultAsset': defaultAsset,
      'id': id,
      'pathAndroid': pathAndroid,
      'pathIos': pathIos,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'scaleX': scaleX,
      'scaleY': scaleY,
      'scaleZ': scaleZ,
      'rotationX': rotationX,
      'rotationY': rotationY,
      'rotationZ': rotationZ,
      'positionX': positionX,
      'positionY': positionY,
      'positionZ': positionZ,
      'locations': locations.map((location) => location.toMap()).toList(),
    };
  }

  factory AssetModel.fromMap(Map<String, dynamic> data) {
    final dynamic updatedAtData = data['updated_at'];
    final dynamic createdAtData = data['created_at'];
    final dynamic scaleXData = data['scale_x'];
    final dynamic scaleYData = data['scale_y'];
    final dynamic scaleZData = data['scale_z'];
    final dynamic rotationXData = data['rotation_x'];
    final dynamic rotationYData = data['rotation_y'];
    final dynamic rotationZData = data['rotation_z'];
    final dynamic positionXData = data['position_x'];
    final dynamic positionYData = data['position_y'];
    final dynamic positionZData = data['position_z'];
    DateTime updatedAt;
    DateTime createdAt;

    if (updatedAtData is Timestamp) {
      updatedAt = updatedAtData.toDate();
    } else if (updatedAtData is DateTime) {
      updatedAt = updatedAtData;
    }

    if (createdAtData is Timestamp) {
      createdAt = createdAtData.toDate();
    } else if (createdAtData is DateTime) {
      createdAt = createdAtData;
    }
    final double scaleX =
        scaleXData is int ? scaleXData.toDouble() : scaleXData as double;
    final double scaleY =
        scaleYData is int ? scaleYData.toDouble() : scaleYData as double;
    final double scaleZ =
        scaleZData is int ? scaleZData.toDouble() : scaleZData as double;
    final double rotationX = rotationXData is int
        ? rotationXData.toDouble()
        : rotationXData as double;
    final double rotationY = rotationYData is int
        ? rotationYData.toDouble()
        : rotationYData as double;
    final double rotationZ = rotationZData is int
        ? rotationZData.toDouble()
        : rotationZData as double;
    final double positionX = positionXData is int
        ? positionXData.toDouble()
        : positionXData as double;
    final double positionY = positionYData is int
        ? positionYData.toDouble()
        : positionYData as double;
    final double positionZ = positionZData is int
        ? positionZData.toDouble()
        : positionZData as double;

    return AssetModel(
      name: data['name'],
      defaultAsset: data['default'],
      pathAndroid: data['path_android'],
      pathIos: data['path_ios'],
      updatedAt: updatedAt ?? DateTime.now(),
      createdAt: createdAt ?? DateTime.now(),
      scaleX: scaleX,
      scaleY: scaleY,
      scaleZ: scaleZ,
      rotationX: rotationX,
      rotationY: rotationY,
      rotationZ: rotationZ,
      positionX: positionX,
      positionY: positionY,
      positionZ: positionZ,
    );
  }
}

class Location {
  Location({this.id, this.name, this.position, this.rule});

  String id;
  final String name;
  final LatLng position;
  final double rule;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'position': GeoPoint(position.latitude, position.longitude),
      'rule': rule,
    };
  }

  factory Location.fromMap(Map<String, dynamic> data) {
    final GeoPoint geoPoint = data['position'] as GeoPoint;

    final dynamic ruleData = data['rule'];
    final double rule =
        ruleData is int ? ruleData.toDouble() : ruleData.toDouble() as double;

    return Location(
      name: data['name'],
      position: LatLng(geoPoint.latitude, geoPoint.longitude),
      rule: rule,
    );
  }
}
