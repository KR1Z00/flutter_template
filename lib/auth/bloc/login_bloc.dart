import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginInitial()) {
    on<LoginUserEvent>(_onLoginUserEvent);
    on<LoginForgotPasswordEvent>(_onLoginForgotPasswordEvent);
    on<LoginRecoverPasswordEvent>(_onLoginRecoverPasswordEvent);
    on<LoginForgotPasswordCancelEvent>(_onLoginForgotPasswordCancelEvent);
  }

  Future<void> _onLoginUserEvent(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginInitial(processing: true));
    try {
      await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );
    } on FirebaseAuthException catch (exception) {
      debugPrint(exception.message);
      emit(const LoginInitial(
        loginError: LoginError.invalidCredentials,
      ));
      return;
    } catch (exception) {
      debugPrint(exception.toString());
      emit(const LoginInitial(
        loginError: LoginError.unknown,
      ));
      return;
    }
    emit(const LoginSuccessfulState());
  }

  void _onLoginForgotPasswordEvent(
    LoginForgotPasswordEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(const LoginRecoverPasswordState(emailSent: false));
  }

  Future<void> _onLoginRecoverPasswordEvent(
    LoginRecoverPasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginRecoverPasswordState(emailSent: false, processing: true));
    try {
      await _authRepository.sendPasswordResetEmail(email: event.email);
      emit(const LoginRecoverPasswordState(emailSent: true));
    } on FirebaseAuthException catch (exception) {
      debugPrint("FirebaseAuthException: ${exception.message}");
      emit(const LoginRecoverPasswordState(
        emailSent: false,
        loginError: LoginError.unknown,
      ));
    } catch (exception) {
      emit(const LoginInitial(
        loginError: LoginError.unknown,
      ));
      return;
    }
  }

  void _onLoginForgotPasswordCancelEvent(
    LoginForgotPasswordCancelEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(const LoginInitial());
  }
}
