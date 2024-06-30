part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  /// An optional error that has occurred during the login
  final LoginError? loginError;
  final bool processing;

  const LoginState({
    this.loginError,
    this.processing = false,
  });

  @override
  List<Object?> get props => [
        loginError,
        processing,
      ];
}

final class LoginInitial extends LoginState {
  const LoginInitial({
    super.loginError,
    super.processing,
  });
}

/// The state when the user has successfully logged in
final class LoginSuccessfulState extends LoginState {
  const LoginSuccessfulState({
    super.loginError,
    super.processing,
  });
}

/// The state when the user wants to recover their password
final class LoginRecoverPasswordState extends LoginState {
  /// [true] if the password recovery email has been sent
  final bool emailSent;

  const LoginRecoverPasswordState({
    required this.emailSent,
    super.loginError,
    super.processing,
  });

  @override
  List<Object?> get props => super.props + [emailSent];
}

/// An error that occur during a user's login
enum LoginError {
  /// An unknown error occurred
  unknown("An error occurred, please try again"),

  /// The user entered invalid credentials
  invalidCredentials("Incorrect email / password combination"),
  ;

  final String errorDescription;

  const LoginError(this.errorDescription);
}
