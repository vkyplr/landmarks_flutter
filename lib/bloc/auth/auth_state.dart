part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// Actionable States
final class AuthActionState extends AuthState {}

// Login Success State
final class AuthSuccessNavigateToHome extends AuthActionState {}

// UI Building States
final class AuthLoadingState extends AuthState {}

// Error State
final class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState({required this.message});
}

// Validation State
final class AuthValidationState extends AuthState {
  final bool isValidEmail;
  final bool isValidPassword;

  AuthValidationState(
      {required this.isValidEmail, required this.isValidPassword});
}

// Not Logged im State
final class AuthNotLoggedInState extends AuthState {}
