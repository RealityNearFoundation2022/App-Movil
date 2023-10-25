part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

// ADD CONTACT
class ContactAddLoading extends ContactState {}

class ContactAdded extends ContactState {}

class ContactAddFail extends ContactState {}
