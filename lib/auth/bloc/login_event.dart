part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

/// The event to log a user in
class LoginUserEvent extends LoginEvent {
  /// The email entered by the user
  final String email;

  /// The password entered by the user
  final String password;

  const LoginUserEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props =>
      super.props +
      [
        email,
        password,
      ];
}

/// The event when the user has forgotten their password
class LoginForgotPasswordEvent extends LoginEvent {
  const LoginForgotPasswordEvent();
}

/// The event when the user wants to recover their password
class LoginRecoverPasswordEvent extends LoginEvent {
  /// The email of the user who has forgotten their password
  final String email;

  const LoginRecoverPasswordEvent({required this.email});
}

/// The event when the user went into the forgot password UI, but then cancelled
class LoginForgotPasswordCancelEvent extends LoginEvent {
  const LoginForgotPasswordCancelEvent();
}
