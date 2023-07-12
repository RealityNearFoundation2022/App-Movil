import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/models/contactModel.dart';
import 'package:reality_near/data/repository/contactRepository.dart';
import 'package:reality_near/data/repository/user_repository.dart';
import 'package:reality_near/domain/entities/user.dart';

class GetRequestsUseCase {
  final ContactRepository _repo = ContactRepository();
  final UserRepository _userRepo = UserRepository();

  Future<List<ContactModel>> getPendingRequest() async {
    final String userId = await getPreference('userId');
    List<ContactModel> lstRequest = [];
    await _repo.getPendingContacts().then((value) => value.fold(
          (failure) => print(failure),
          (success) => lstRequest = success
                .where((element) => element.contactId.toString() == userId)
                .toList(),
        ));
    return lstRequest;
  }

  Future<List<User>> call() async {
    //CONTACTOS - Obtenemos lista de solicitudes pendientes
    List<ContactModel> lstContactRequest = await getPendingRequest();

    //CONTACTOS - Obtenemos los datos de usuarios en la lista anterior
    List<User> lstUserRequest = [];

    for (var contact in lstContactRequest) {
      User user = User();
      await _userRepo
          .getUserById(contact.ownerId.toString())
          .then((value) => value.fold(
                (failure) => print(failure),
                (success) => user = success,
              ));
      user.infContact = contact;
      lstUserRequest.add(user);
    }

    return lstUserRequest;
  }
}
