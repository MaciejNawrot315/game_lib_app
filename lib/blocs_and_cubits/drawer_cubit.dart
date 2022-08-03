import 'package:bloc/bloc.dart';

enum DrawerState {
  initial,
  login,
  register,
}

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerState.initial);
  void changeToLoginState() => emit(DrawerState.login);
  void changeToInitialState() => emit(DrawerState.initial);
  void changeToRegisterState() => emit(DrawerState.register);
}
