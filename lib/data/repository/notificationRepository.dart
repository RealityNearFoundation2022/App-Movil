import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/datasource/API/notification_datadource.dart';
import 'package:reality_near/data/models/notificationModel.dart';

class NotificationRepository {
  final NotificationRemoteDataSourceImpl contactRepo =
      NotificationRemoteDataSourceImpl();

  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      var response = await contactRepo.getNotifications();
      return Right(response);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  Future<Either<Failure, List<NotificationModel>>> getNotificationsHis() async {
    try {
      var response = await contactRepo.getNotificationsHis();
      return Right(response);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  Future<Either<Failure, bool>> readNotification(int notificationId) async {
    try {
      var response = await contactRepo.readNotification(notificationId);
      return response
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
}
