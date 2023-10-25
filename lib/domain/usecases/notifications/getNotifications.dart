import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/repository/notificationRepository.dart';

class GetNotifications {
  final NotificationRepository _repo = NotificationRepository();

  Future<Either<Failure, int>> call() async {
    Failure _fail;
    int _countNotifications = 0;
    //get number of notifications
    await _repo.getNotifications().then((value) =>
        value.fold((l) => _fail = l, (r) => _countNotifications = r.length));

    return _fail == null ? Right(_countNotifications) : Left(_fail);
  }
}
