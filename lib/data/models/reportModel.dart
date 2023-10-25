// To parse this JSON data, do
//
//     final ReportModel = ReportModelFromJson(jsonString);

import 'dart:convert';

ReportModel ReportModelFromJson(String str) =>
    ReportModel.fromJson(json.decode(str));

String ReportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  ReportModel({
    this.category,
    this.title,
    this.description,
    this.status,
    this.image,
  });

  final String category;
  final String title;
  final String description;
  final int status;
  final String image;

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        category: json["category"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "title": title,
        "description": description,
        "status": status,
        "image": image,
      };
}
