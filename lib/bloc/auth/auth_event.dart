part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSubmitEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSubmitEvent({required this.email, required this.password});
}

class AuthCheckLoginEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}
