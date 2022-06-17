import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reality_near/domain/usecases/wallet/walletLogin.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
//Evento para Login
    on<UserLoginEvent>((event, emit) async {
      final WalletLogin walletLogin = WalletLogin(event.walletId);
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
  }
}
