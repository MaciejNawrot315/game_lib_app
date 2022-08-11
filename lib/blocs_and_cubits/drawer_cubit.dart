// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:game_lib_app/repositories/fb_auth_repository.dart';

enum DrawerState {
  initial,
  login,
  register,
  restart,
}

class DrawerCubit extends Cubit<DrawerState> {
  final AuthRepository authRepository;
  DrawerCubit({
    required this.authRepository,
  }) : super(DrawerState.initial);
  void changeToLoginState() => emit(DrawerState.login);
  void changeToInitialState() => emit(DrawerState.initial);
  void changeToRegisterState() => emit(DrawerState.register);
  void changeToRestartState() => emit(DrawerState.restart);

  void sendResetEmail({required String email}) {
    authRepository.resetPass(email: email);
  }
}
