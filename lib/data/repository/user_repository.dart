import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/datasource/firebase/fs_auth_service.dart';
import 'package:reality_near/data/datasource/firebase/fs_users_service.dart';
import 'package:reality_near/data/models/user_model.dart';

class UserRepository {
  FsAuthService authService = FsAuthService();
  FsUsersService usersService = FsUsersService();
  Future<void> editUser(String avatar, String username, String email) async {
    // await userRemoteDataSource.editUserData(avatar, username, email);
  }

  Future<Either<Failure, UserModel>> registerNewUser(
      String email, String password, String username, String path) async {
    try {
      var authUser =
          await authService.createUserWithEmailAndPassword(email, password);
      var user = await usersService.createUser(
          authUser.user.uid, email, username, path);
      return Right(user);
    } on Exception catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
      ));
    }
  }

  Future<Either<Failure, bool>> loginwithEmail(
      String email, String password) async {
    try {
      final isLoggedIn =
          await authService.signInWithEmailAndPassword(email, password);
      return Right(isLoggedIn != null);
    } on Exception catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
      ));
    }
  }

  Future<Either<Failure, UserModel>> getMyData() async {
    try {
      final userPreference = await getPreference('user');
      if (userPreference == null) {
        final uid = await getPreference('uid');
        final user = await usersService.getUser(uid);
        setPreference('user', user.userModelToJson(user));
        return Right(user);
      } else {
        final user = UserModel().userModelFromJson(userPreference);
        return Right(user);
      }
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  // Future<Either<Failure, List<User>>> getUsers() async {
  //   try {
  //     final users = await userRemoteDataSource.getUsers();
  //     return Right(users);
  //   } on ServerException {
  //     return const Left(ServerFailure(
  //       message: "Server Failure",
  //     ));
  //   }
  // }

  // Future<Either<Failure, User>> getUserById(String userId) async {
  //   try {
  //     final user = await userRemoteDataSource.getUserById(userId);
  //     return Right(user);
  //   } on ServerException {
  //     return const Left(ServerFailure(
  //       message: "Server Failure",
  //     ));
  //   }
  // }
}
