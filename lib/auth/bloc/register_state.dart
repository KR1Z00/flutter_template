part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

/// The initial [RegisterState]
final class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

/// The state when the Register is processing
final class RegisterProcessingState extends RegisterState {
  const RegisterProcessingState();
}

/// The state when the Register is successful
final class RegisterSuccessfulState extends RegisterState {
  const RegisterSuccessfulState();
}

/// The state when the Register has an error
final class RegisterErrorState extends RegisterState {
  /// The specific [RegisterError] that occurred
  final RegisterError error;

  const RegisterErrorState({required this.error});

  @override
  List<Object> get props => super.props + [error];
}

/// The possible errors that can occur when registering
enum RegisterError {
  /// An unknown error occurred
  unknown("An error occurred, please try again"),

  /// Some of the values passed were empty
  emptyValues("Please enter all the required values"),

  /// The email provided was of an invalid format
  invalidEmail("Please enter a valid email"),

  /// The email provided is already in use
  emailInUse("The email provided is already in use"),

  /// The password was too weak
  weakPassword("Please enter a stronger password"),
  ;

  final String errorDescription;

  const RegisterError(this.errorDescription);
}
