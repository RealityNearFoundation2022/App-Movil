part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoginEvent extends UserEvent {
  final String walletId;
  final BuildContext context;

  const UserLoginEvent(this.context, this.walletId);

  @override
  List<Object> get props => [walletId];
}

class UserLoginAgainEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class UserRegisterEvent extends UserEvent {
  final String email;
  final String password;
  final String username;

  const UserRegisterEvent(this.email, this.password, this.username);

  List<Object> get props => [email, password, username];
}
