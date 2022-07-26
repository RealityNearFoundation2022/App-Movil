import 'package:reality_near/data/models/contactModel.dart';

class User {
  User({
    this.email,
    this.isActive,
    this.isSuperuser,
    this.fullName,
    this.id,
    this.infContact,
  });

  final String email;
  final bool isActive;
  final bool isSuperuser;
  final String fullName;
  final int id;
  ContactModel infContact;
}
