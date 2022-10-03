import 'dart:convert';

ContactModel contactModelFromJson(String str) => ContactModel.fromJson(json.decode(str));

String contactModelToJson(ContactModel data) => json.encode(data.toJson());

class ContactModel {
  ContactModel({
    this.pending,
    this.contactId,
    this.locked,
    this.id,
    this.ownerId,
  });

  int pending;
  int contactId;
  int locked;
  int id;
  int ownerId;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    pending: json["pending"],
    contactId: json["contact_id"],
    locked: json["locked"],
    id: json["id"],
    ownerId: json["owner_id"],
  );

  Map<String, dynamic> toJson() => {
    "pending": pending,
    "contact_id": contactId,
    "locked": locked,
    "id": id,
    "owner_id": ownerId,
  };
}
