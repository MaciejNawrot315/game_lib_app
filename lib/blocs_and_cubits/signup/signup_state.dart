// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_cubit.dart';

enum SignupStatus {
  initial,
  submitting,
  success,
  error,
}

class SignupState {
  final SignupStatus signupStatus;
  final CustomError error;
  SignupState({
    required this.signupStatus,
    required this.error,
  });

  factory SignupState.initial() {
    return SignupState(
      signupStatus: SignupStatus.initial,
      error: CustomError(),
    );
  }

  SignupState copyWith({
    SignupStatus? signupStatus,
    CustomError? error,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
      error: error ?? this.error,
    );
  }
}
