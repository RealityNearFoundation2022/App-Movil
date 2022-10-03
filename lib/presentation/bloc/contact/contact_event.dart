part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

// ADD CONTACT
class ContactAddEvent extends ContactEvent {
  final String contactId;

  const ContactAddEvent(this.contactId);

  @override
  List<Object> get props => [contactId];
}
