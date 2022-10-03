import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reality_near/data/repository/contactRepository.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactRepository _contactRepo;
  ContactBloc() : super(ContactInitial()) {
    on<ContactEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ContactAddEvent>((event, emit) async {
      final resp = await _contactRepo.addContact(event.contactId);
      emit(ContactAddLoading());
      resp.isRight() ? emit(ContactAdded()) : emit(ContactAddFail());
    });
  }
}
