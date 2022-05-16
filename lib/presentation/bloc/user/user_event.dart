part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoginEvent extends UserEvent {
  final String walletId;

  const UserLoginEvent(this.walletId);

  @override
  List<Object> get props => [walletId];
}

class UserLoginAgainEvent extends UserEvent {
  @override
  List<Object> get props => [];
}
