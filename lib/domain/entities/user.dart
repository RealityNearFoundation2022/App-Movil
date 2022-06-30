class User {
  User({
    this.email,
    this.isActive,
    this.isSuperuser,
    this.fullName,
    this.id,
  });

  final String email;
  final bool isActive;
  final bool isSuperuser;
  final String fullName;
  final int id;
}
