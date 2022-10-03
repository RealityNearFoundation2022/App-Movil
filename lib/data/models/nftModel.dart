// To parse this JSON data, do
//
//     final nftModel = nftModelFromJson(jsonString);

import 'dart:convert';

NftModel nftModelFromJson(String str) => NftModel.fromJson(json.decode(str));

String nftModelToJson(NftModel data) => json.encode(data.toJson());

class NftModel {
  NftModel({
    this.tokenId,
    this.ownerId,
    this.metadata,
    this.approvedAccountIds,
    this.royalty,
  });

  final String tokenId;
  final String ownerId;
  final Metadata metadata;
  final ApprovedAccountIds approvedAccountIds;
  final ApprovedAccountIds royalty;

  factory NftModel.fromJson(Map<String, dynamic> json) => NftModel(
        tokenId: json["token_id"],
        ownerId: json["owner_id"],
        metadata: Metadata.fromJson(json["metadata"]),
        approvedAccountIds:
            ApprovedAccountIds.fromJson(json["approved_account_ids"]),
        royalty: ApprovedAccountIds.fromJson(json["royalty"]),
      );

  Map<String, dynamic> toJson() => {
        "token_id": tokenId,
        "owner_id": ownerId,
        "metadata": metadata.toJson(),
        "approved_account_ids": approvedAccountIds.toJson(),
        "royalty": royalty.toJson(),
      };
}

class ApprovedAccountIds {
  ApprovedAccountIds();

  factory ApprovedAccountIds.fromJson(Map<String, dynamic> json) =>
      ApprovedAccountIds();

  Map<String, dynamic> toJson() => {};
}

class Metadata {
  Metadata({
    this.title,
    this.description,
    this.media,
    this.mediaHash,
    this.copies,
    this.issuedAt,
    this.expiresAt,
    this.startsAt,
    this.updatedAt,
    this.extra,
    this.reference,
    this.referenceHash,
  });

  final String title;
  final String description;
  final String media;
  final dynamic mediaHash;
  final dynamic copies;
  final dynamic issuedAt;
  final dynamic expiresAt;
  final dynamic startsAt;
  final dynamic updatedAt;
  final dynamic extra;
  final dynamic reference;
  final dynamic referenceHash;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        title: json["title"],
        description: json["description"],
        media: json["media"],
        mediaHash: json["media_hash"],
        copies: json["copies"],
        issuedAt: json["issued_at"],
        expiresAt: json["expires_at"],
        startsAt: json["starts_at"],
        updatedAt: json["updated_at"],
        extra: json["extra"],
        reference: json["reference"],
        referenceHash: json["reference_hash"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "media": media,
        "media_hash": mediaHash,
        "copies": copies,
        "issued_at": issuedAt,
        "expires_at": expiresAt,
        "starts_at": startsAt,
        "updated_at": updatedAt,
        "extra": extra,
        "reference": reference,
        "reference_hash": referenceHash,
      };
}
