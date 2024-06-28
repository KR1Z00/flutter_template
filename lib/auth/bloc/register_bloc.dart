import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RegisterInitial()) {
    on<RegisterNewUserEvent>(_onRegisterNewUserEvent);
  }

  Future<void> _onRegisterNewUserEvent(
    RegisterNewUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    if (event.email.isEmpty ||
        event.name.isEmpty ||
        event.password.isEmpty ||
        event.phoneNumber.isEmpty) {
      emit(const RegisterErrorState(error: RegisterError.emptyValues));
      return;
    }

    if (!EmailValidator.validate(event.email)) {
      emit(const RegisterErrorState(error: RegisterError.invalidEmail));
      return;
    }

    emit(const RegisterProcessingState());

    try {
      await _authRepository.registerNewUser(
        email: event.email,
        password: event.password,
        name: event.name,
        phoneNumber: event.phoneNumber,
      );

      print("Done");
    } on FirebaseAuthException catch (firebaseAuthException) {
      switch (firebaseAuthException.code) {
        case 'email-in-use':
          emit(const RegisterErrorState(
            error: RegisterError.emailInUse,
          ));
        case 'weak-password':
          emit(const RegisterErrorState(
            error: RegisterError.weakPassword,
          ));
      }

      return;
    } catch (exception) {
      emit(const RegisterErrorState(
        error: RegisterError.unknown,
      ));
      return;
    }

    emit(const RegisterSuccessfulState());
  }
}
