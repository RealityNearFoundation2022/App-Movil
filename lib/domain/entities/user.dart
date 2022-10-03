import 'package:reality_near/data/models/contactModel.dart';

class User {
  User({
    this.email,
    this.isActive,
    this.isSuperuser,
    this.fullName,
    this.path,
    this.avatar,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.infContact,
  });

  final String email;
  final bool isActive;
  final bool isSuperuser;
  final String fullName;
  final String path;
  final String avatar;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  ContactModel infContact;
}
