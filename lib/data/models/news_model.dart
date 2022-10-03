// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

class NewsModel {
  NewsModel({
    this.id,
    this.image,
    this.title,
    this.description,
    this.planners,
    this.date,
    this.url,
    this.articles,
  });

  final String id;
  final String image;
  final String title;
  final String description;
  final String planners;
  final String date;
  final String url;
  final List<Article> articles;

  factory NewsModel.fromRawJson(String str) =>
      NewsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["_id"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
        planners: json["planners"],
        date: json["date"],
        url: json["url"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "title": title,
        "description": description,
        "planners": planners,
        "date": date,
        "url": url,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    this.data,
    this.image,
  });

  final String data;
  final String image;

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        data: json["data"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "image": image,
      };
}
