import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/repository/contactRepository.dart';

class AcceptRequestUseCase {
  final ContactRepository _repo = ContactRepository();
  final String contactId;
  AcceptRequestUseCase(this.contactId);

  Future<Either<Failure, bool>> call() async {
    return await _repo.acceptPendingContact(contactId);
  }
}
