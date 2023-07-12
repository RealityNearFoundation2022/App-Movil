import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/models/notificationModel.dart';
import 'package:reality_near/data/repository/notificationRepository.dart';
import 'package:reality_near/data/repository/user_repository.dart';

class GetNotificationsHistory {
  final NotificationRepository _repo = NotificationRepository();
  final UserRepository _userRepo = UserRepository();

  Future<Either<Failure, List<NotificationModel>>> call() async {
    List<NotificationModel> lstNotifications = [];
    Failure _failed;
    await _repo.getNotificationsHis().then((value) => value.fold(
          (failure) => _failed = failure,
          (success) => {lstNotifications = success},
        ));
    await _repo.getNotifications().then((value) => value.fold(
          (failure) => _failed = failure,
          (success) => {lstNotifications.addAll(success)},
        ));
    return _failed != null ? Left(_failed) : Right(lstNotifications);
  }
}
