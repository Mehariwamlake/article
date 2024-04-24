part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthenticationEvent {
  final AuthenticationEntites authCredentials;

  const LoginEvent({required this.authCredentials});

  @override
  List<Object> get props => [authCredentials];
}

class SignupEvent extends AuthenticationEvent {
  final AuthenticationEntites newAuthCredentials;

  const SignupEvent({required this.newAuthCredentials});

  @override
  List<Object> get props => [newAuthCredentials];
}

class GetTokenEvent extends AuthenticationEvent {}
