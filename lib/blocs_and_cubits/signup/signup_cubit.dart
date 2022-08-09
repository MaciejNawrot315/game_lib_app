import 'package:bloc/bloc.dart';
import 'package:game_lib_app/models/custom_error.dart';
import 'package:game_lib_app/repositories/fb_auth_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository authRepository;
  SignupCubit({
    required this.authRepository,
  }) : super(SignupState.initial());

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(
      signupStatus: SignupStatus.submitting,
    ));

    try {
      await authRepository.signUp(
        name: name,
        email: email,
        password: password,
      );
      emit(state.copyWith(
        signupStatus: SignupStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        signupStatus: SignupStatus.error,
        error: e,
      ));
    }
  }
}
