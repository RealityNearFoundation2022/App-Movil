import 'dart:convert';

class UserModel {
  UserModel({
    this.email,
    this.isActive,
    this.isSuperuser,
    this.username,
    this.photoUrl,
    this.avatar,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  final String email;
  final bool isActive;
  final bool isSuperuser;
  final String username;
  final String photoUrl;
  final String avatar;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Método para crear una instancia del modelo de datos a partir de un DocumentSnapshot
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'] ?? '',
      isActive: data['isActive'] ?? false,
      isSuperuser: data['isSuperuser'] ?? false,
      username: data['username'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      avatar: data['avatar'] ?? '',
      id: data['id'] ?? 0,
      createdAt: data['createdAt'] ?? DateTime.now(),
      updatedAt: data['updatedAt'] ?? DateTime.now(),
    );
  }

  // Método para convertir el modelo de datos a un mapa (para guardar en Firestore)
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'isActive': isActive,
      'isSuperuser': isSuperuser,
      'username': username,
      'photoUrl': photoUrl,
      'avatar': avatar,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  userModelFromJson(String str) => UserModel.fromMap(json.decode(str));

  String userModelToJson(UserModel data) => json.encode(data.toMap());
}
