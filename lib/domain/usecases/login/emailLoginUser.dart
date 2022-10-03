import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/repository/userRepository.dart';

class EmailLoginUser {
  UserRepository userRepository = UserRepository();
  final String email;
  final String password;
  EmailLoginUser(this.email, this.password);

  Future<Either<Failure, bool>> call() async {
    return await userRepository.loginwithEmail(email, password);
  }
}
