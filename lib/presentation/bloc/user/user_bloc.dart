import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:reality_near/domain/usecases/register/registerUser.dart';
import 'package:reality_near/domain/usecases/wallet/walletLogin.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
//Evento para Login
    on<UserLoginEvent>((event, emit) async {
      final WalletLogin walletLogin =
          WalletLogin(event.context, event.walletId);
      emit(UserLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      final result = await walletLogin();
      emit(UserLoggedInState(result.isRight()));
    });
//Evento para intentar Login de nuevo
    on<UserLoginAgainEvent>(
      (event, emit) {
        emit(UserInitialState());
      },
    );
    //Evento para registrar un nuevo usuario
    on<UserRegisterEvent>((event, emit) async {
      final RegisterUser registerUser =
          RegisterUser(event.email, event.password, event.username);
      final result = await registerUser();
      // emit(UserLoadingState());
      // // await Future.delayed(const Duration(seconds: 1));
      // emit(UserRegisteredState());
    });
  }
}
