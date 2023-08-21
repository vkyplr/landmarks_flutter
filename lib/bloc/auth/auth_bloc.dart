import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_famous_landmarks/data/models/auth_network_response_model.dart';
import 'package:world_famous_landmarks/repository/landmarks/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSubmitEvent>(authSubmitEvent);
    on<AuthCheckLoginEvent>(authCheckLoginEvent);
    on<AuthLogoutEvent>(authLogoutEvent);
  }

  FutureOr<void> authSubmitEvent(
      AuthSubmitEvent event, Emitter<AuthState> emit) async {
    // Emitting Loading State
    emit(AuthLoadingState());

    final dynamic response =
        await AuthRepo.login(email: event.email, password: event.password);

    if (response is AuthNetworkResponseModel) {
      //Emitting Success State if Login is Successful
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', event.email);
      emit(AuthSuccessNavigateToHome());
    } else {
      // Emitting Error State if Login is Not Successful
      emit(AuthErrorState(message: response.message));
    }
  }

  FutureOr<void> authCheckLoginEvent(
      AuthCheckLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');
      // Check if Email is Present in Shared Preferences
      if (email != null) {
        // Emit Success State if Login Daa is Present
        emit(AuthSuccessNavigateToHome());
      } else {
        // Emit Error State if Login Data is not Present
        emit(AuthNotLoggedInState());
      }
    } catch (e) {
      emit(AuthNotLoggedInState());
    }
  }

  FutureOr<void> authLogoutEvent(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    emit(AuthLoggedOutState());
  }
}
