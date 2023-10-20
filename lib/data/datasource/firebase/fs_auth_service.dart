import 'package:firebase_auth/firebase_auth.dart';

class FsAuthService {
  //Create User with Email and Password
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return throw Exception('La contraseña es muy débil.');
      } else if (e.code == 'email-already-in-use') {
        return throw Exception('El correo ya está asociado a una cuenta.');
      }
    } catch (e) {
      return throw Exception(e.toString());
    }
  }

  //Sign in with Email and Password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return throw Exception('No se encontró una cuenta con ese correo.');
      } else if (e.code == 'wrong-password') {
        return throw Exception('Contraseña incorrecta.');
      }
    } catch (e) {
      return throw Exception(e.toString());
    }
  }
}
