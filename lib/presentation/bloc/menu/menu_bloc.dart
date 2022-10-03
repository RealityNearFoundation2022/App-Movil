import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitialState()) {
    on<MenuOpenInitEvent>((event, emit) {
      emit(MenuPrincipalState());
    });
    on<MenuCloseEvent>((event, emit) {
      emit(MenuInitialState());
    });
    on<MenuOpenMapEvent>((event, emit) {
      emit(MenuMapaState());
    });
    on<MenuOpenArViewEvent>((event, emit) {
      emit(MenuArState());
    });
  }
}
