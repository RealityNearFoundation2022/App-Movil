
import 'package:meta/meta.dart';
import 'dart:convert';

AssignCuponModel AssignCuponModelFromJson(String str) => AssignCuponModel.fromJson(json.decode(str));

String AssignCuponModelToJson(AssignCuponModel data) => json.encode(data.toJson());

class AssignCuponModel {
  AssignCuponModel({
    @required this.couponId,
    @required this.ownerId,
    @required this.redeemed,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int couponId;
  int ownerId;
  bool redeemed;
  DateTime createdAt;
  DateTime updatedAt;

  factory AssignCuponModel.fromJson(Map<String, dynamic> json) => AssignCuponModel(
    couponId: json["coupon_id"],
    ownerId: json["owner_id"],
    redeemed: json["redeemed"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "coupon_id": couponId,
    "owner_id": ownerId,
    "redeemed": redeemed,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
