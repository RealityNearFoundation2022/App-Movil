import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/domain/usecases/login/emailLoginUser.dart';
import 'package:reality_near/domain/usecases/register/register_user.dart';
import 'package:reality_near/domain/usecases/wallet/walletLogin.dart';
import 'package:reality_near/generated/l10n.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
//Evento para Login con Wallet
    on<UserLoginWalletEvent>((event, emit) async {
      final WalletLogin walletLogin = WalletLogin(event.context);
      final result = await walletLogin();
      emit(UserLoggedInState(result.isRight()));
    });

//Evento para Login con Email
    on<UserLoginEmailEvent>((event, emit) async {
      final EmailLoginUser login =
          EmailLoginUser(event.username, event.password);
      emit(UserLoadingState());
      final result = await login();
      result.fold(
        (failure) => emit(UserFailState(failure.message)),
        (success) => emit(UserLoggedInState(success)),
      );
    });

//Evento para intentar Login de nuevo
    on<UserLoginAgainEvent>(
      (event, emit) {
        emit(UserInitialState());
      },
    );
//Evento para cerrar sesión
    on<UserLogOutEvent>(
      (event, emit) {
        emit(UserInitialState());
        deleteAllsetPreference();
      },
    );

    on<UserDeleteAccountEvent>(
      (event, emit) {
        // AuthsRemoteDataSourceImpl().deleteAccount();
        emit(UserInitialState());
        deleteAllsetPreference();
      },
    );

//Evento para registrar un nuevo usuario
    on<UserRegisterEvent>((event, emit) async {
      final RegisterUser registerUser =
          RegisterUser(event.email, event.password, event.username, event.path);

      final result = await registerUser();

      if (result.isLeft()) {
        emit(UserFailState(
            result.fold((l) => S.current.registerFail, (r) => null)));
      }

      final EmailLoginUser login = EmailLoginUser(event.email, event.password);

      await login();

      emit(UserLoggedInState(result.isRight()));
    });
  }
}
