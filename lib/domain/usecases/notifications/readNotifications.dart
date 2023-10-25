import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/models/notificationModel.dart';
import 'package:reality_near/data/repository/notificationRepository.dart';

class ReadNotifications {
  final NotificationRepository _repo = NotificationRepository();
  final List<NotificationModel> lstNotifications;
  ReadNotifications(this.lstNotifications);
  Future<Either<Failure, bool>> call() async {
    Failure _fail;

    //update all notifications as read
    for (var notification
        in lstNotifications.where((element) => element.read == 0)) {
      await _repo.readNotification(notification.id).then((value) => value.fold(
            (failure) => _fail = failure,
            (success) => {},
          ));
    }

    return _fail == null ? const Right(true) : Left(_fail);
  }
}
