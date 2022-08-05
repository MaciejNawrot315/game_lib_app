part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthStateChangedEvent extends AuthEvent {
  final fb_auth.User? user;
  AuthStateChangedEvent({
    this.user,
  });
}

class SignoutRequestedEvent extends AuthEvent {}
