import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/models/user_model.dart';

class FsUsersService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel> createUser(
      String uid, String email, String username, String avatar) async {
    try {
      await firestore.collection('users').doc(uid).set({
        'id': uid,
        'email': email,
        'isActive': true,
        'isSuperuser': false,
        'username': username,
        'photoUrl': '',
        'avatar': avatar,
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });
      var user = UserModel(
        email: email,
        isActive: true,
        isSuperuser: false,
        username: username,
        photoUrl: '',
        avatar: avatar,
        id: uid,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      setPreference('user', user.userModelToJson(user));
      return user;
    } on Exception catch (e) {
      return throw Exception(e.toString());
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      var userSnapshot = await firestore.collection('users').doc(uid).get();
      var user = UserModel.fromMap(userSnapshot.data());
      setPreference('user', user.userModelToJson(user));
      return user;
    } on Exception catch (e) {
      return throw Exception(e.toString());
    }
  }
}
