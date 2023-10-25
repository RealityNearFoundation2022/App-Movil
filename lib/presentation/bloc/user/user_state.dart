part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {
  @override
  List<Object> get props => [];
}

//User loaded
class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

//User se logeo correctamente
class UserLoggedInState extends UserState {
  final bool isLoggedIn;

  const UserLoggedInState(this.isLoggedIn);
  @override
  List<Object> get props => [isLoggedIn];
}

// User tuvo un error
class UserFailState extends UserState {
  final String message;

  const UserFailState(this.message);

  @override
  List<Object> get props => [message];
}

//User se registro correctamente
class UserRegisterSuccessState extends UserState {
  final bool isRegisterIn;

  const UserRegisterSuccessState(this.isRegisterIn);
  @override
  List<Object> get props => [isRegisterIn];
}
