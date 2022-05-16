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
    on<MenuOpenCongifEvent>((event, emit) {
      emit(MenuConfiguracionState());
    });
    on<MenuOpenMapEvent>((event, emit) {
      emit(MenuMapaState());
    });
    on<MenuOpenInfoEvent>((event, emit) {
      emit(MenuInformacionState());
    });
    on<MenuOpenBugEvent>((event, emit) {
      emit(MenuBugState());
    });
  }
}
