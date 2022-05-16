import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
//Evento para Login
    on<UserLoginEvent>((event, emit) async {
      emit(UserLoadingState());
      final walletId = event.walletId;
      await Future.delayed(const Duration(seconds: 1));
      // print('UserBloc - walletID: $walletId = ' + walletId == '123');
      emit(UserLoggedInState(walletId == '123'));
    });
//Evento para intentar Login de nuevo
    on<UserLoginAgainEvent>(
      (event, emit) {
        emit(UserInitialState());
      },
    );
  }
}
