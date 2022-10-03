import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/datasource/API/auth_datasource.dart';
import 'package:reality_near/data/datasource/API/user_datasource.dart';
import 'package:reality_near/domain/entities/user.dart';

class UserRepository {
  final AuthsRemoteDataSourceImpl authsRemoteDataSourceImpl =
      AuthsRemoteDataSourceImpl();

  final userRemoteDataSourceImpl userRemoteDataSource =
      userRemoteDataSourceImpl();

  Future<void> editUser(String password, String username, String avatar) async {
     await userRemoteDataSource.editUserData(password, username, avatar);
  }

  Future<Either<Failure, User>> registerNewUser(
      String email, String password, String username, String path) async {
    try {
      final user = await authsRemoteDataSourceImpl.registerNewUserWithEmail(
          email, password, username, path);
      return Right(user);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  // setAvatar(String avatar,String pasword) async {
  //   await userRemoteDataSource.setAvatar(avatar,pasword);
  // }

  Future<Either<Failure, bool>> loginwithEmail(
      String email, String password) async {
    try {
      final isLoggedIn =
          await authsRemoteDataSourceImpl.loginWithEmail(email, password);
      return isLoggedIn
          ? const Right(true)
          : const Left(ServerFailure(
              message: "Server Failure",
            ));
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  Future<Either<Failure, User>> getMyData() async {
    try {
      final user = await userRemoteDataSource.getMyData();
      return Right(user);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final users = await userRemoteDataSource.getUsers();
      return Right(users);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  Future<Either<Failure, User>> getUserById(String userId) async {
    try {
      final user = await userRemoteDataSource.getUserById(userId);
      return Right(user);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }
}
