import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/models/contactModel.dart';
import 'package:reality_near/data/repository/contactRepository.dart';
import 'package:reality_near/data/repository/userRepository.dart';
import 'package:reality_near/domain/entities/user.dart';

class GetPendingUseCase {
  final ContactRepository _repo = ContactRepository();
  final UserRepository _userRepo = UserRepository();

  Future<List<ContactModel>> getPendingRequest() async {
    final String userId = await getPersistData('userId');
    List<ContactModel> lstRequest = [];
    await _repo.getPendingContacts().then((value) => value.fold(
          (failure) => print(failure),
          (success) => {
            lstRequest = success
                .where((element) => element.ownerId.toString() == userId)
                .toList()
          },
        ));
    return lstRequest;
  }

  Future<List<User>> call() async {
    print('dentro');
    //CONTACTOS - Obtenemos lista de solicitudes pendientes
    List<ContactModel> lstContactRequest = await getPendingRequest();

    //CONTACTOS - Obtenemos los datos de usuarios en la lista anterior
    List<User> lstUserRequest = [];

    //obtenemos lista de usuarios
    await UserRepository().getUsers().then((value) => value.fold(
          (failure) => print(failure),
          (success) => lstUserRequest = success,
        ));
    //obtenemos usuario por ID
    for (var contact in lstContactRequest) {
      User user = User();
      await _userRepo
          .getUserById(contact.contactId.toString())
          .then((value) => value.fold(
                (failure) => print(failure),
                (success) => {user = success},
              ));
      user.infContact = contact;

      //remplazamos usuario en la lista de usuarios
      lstUserRequest.removeWhere((element) => element.id == user.id);
      lstUserRequest.add(user);
    }

    return lstUserRequest;
  }
}
