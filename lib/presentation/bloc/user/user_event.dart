part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoginWalletEvent extends UserEvent {
  final String walletId;
  final BuildContext context;

  const UserLoginWalletEvent(this.context, this.walletId);

  @override
  List<Object> get props => [walletId];
}

class UserLoginEmailEvent extends UserEvent {
  final String username;
  final String password;

  const UserLoginEmailEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class UserLoginAgainEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class UserLogOutEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class UserRegisterEvent extends UserEvent {
  final String email;
  final String password;
  final String username;
  final String path;

  const UserRegisterEvent(this.email, this.password, this.username, this.path);

  List<Object> get props => [email, password, username];
}
