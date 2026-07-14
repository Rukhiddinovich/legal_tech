import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class TogglePasswordVisibility extends AuthEvent {}

class ToggleRememberMe extends AuthEvent {}

class SubmitLogin extends AuthEvent {
  final String login;
  final String password;

  const SubmitLogin({required this.login, required this.password});

  @override
  List<Object?> get props => [login, password];
}
