import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/datasource/API/auth_datasource.dart';
import 'package:reality_near/domain/entities/user.dart';

class UserRepository {
  final AuthsRemoteDataSourceImpl authsRemoteDataSourceImpl =
      AuthsRemoteDataSourceImpl();

  Future<Either<Failure, User>> registerNewUser(
      String email, String password, String username) async {
    try {
      final user = await authsRemoteDataSourceImpl.registerNewUserWithEmail(
          email, password, username);
      return Right(user);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  Future<Either<Failure, bool>> loginwithEmail(
      String email, String password) async {
    try {
      final isLoggedIn =
          await authsRemoteDataSourceImpl.loginWithEmail(email, password);
      return Right(isLoggedIn);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }
}
