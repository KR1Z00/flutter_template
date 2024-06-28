part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterNewUserEvent extends RegisterEvent {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;

  const RegisterNewUserEvent({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object> get props =>
      super.props +
      [
        name,
        email,
        phoneNumber,
        password,
      ];
}
