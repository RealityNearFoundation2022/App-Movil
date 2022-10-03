import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/repository/userRepository.dart';
import 'package:reality_near/domain/entities/user.dart';

class RegisterUser {
  UserRepository userRepository = UserRepository();
  final String email;
  final String password;
  final String username;
  final String path;
  RegisterUser(this.email, this.password, this.username,this.path);

  Future<Either<Failure, User>> call() async {
    return await userRepository.registerNewUser(email, password, username, path);
  }
}
