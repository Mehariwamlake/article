part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final AuthEntity authenticationEntity;

  const Authenticated({required this.authenticationEntity});

  @override
  List<Object> get props => [authenticationEntity];
}

class AuthenticationFailure extends AuthenticationState {
  final Failure error;

  const AuthenticationFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class UserAuthState extends AuthenticationState {
  final String? token;
  const UserAuthState(this.token);
}
