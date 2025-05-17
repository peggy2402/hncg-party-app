// features/auth/presentation/blocs/auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String usernameOrEmail;
  final String password;

  LoginRequested(this.usernameOrEmail, this.password);
}

class SignupRequested extends AuthEvent {
  final String username;
  final String email;
  final String password;

  SignupRequested(this.username, this.email, this.password);
}