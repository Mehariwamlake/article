import 'dart:async';

import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/network/custom_client.dart';
import 'package:article_app/features/auth/domain/entites/auth.dart';
import 'package:article_app/features/auth/domain/entites/auth_entity.dart';
import 'package:article_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final GetTokenUseCase getTokenUsecase;
  final CustomClient customClient;

  AuthenticationBloc({
    required this.customClient,
    required this.getTokenUsecase,
    required this.loginUseCase,
    required this.signupUseCase,
  }) : super(AuthenticationInitial()) {
    on<LoginEvent>(_login);
    on<SignupEvent>(_signup);
    on<GetTokenEvent>(_onGetTokenEvent);
  }

  void _login(LoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final result = await loginUseCase(event.authCredentials);
    emit(_loginSuccessOrFailure(result));
  }

  void _signup(SignupEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final result = await signupUseCase(event.newAuthCredentials);
    emit(_signupSuccessOrFailure(result));
  }

  AuthenticationState _loginSuccessOrFailure(Either<Failure, AuthEntity> data) {
    return data.fold((failure) => AuthenticationFailure(error: failure),
        (success) => Authenticated(authenticationEntity: success));
  }

  AuthenticationState _signupSuccessOrFailure(
      Either<Failure, AuthEntity> data) {
    return data.fold((failure) => AuthenticationFailure(error: failure),
        (success) => Authenticated(authenticationEntity: success));
  }

  FutureOr<void> _onGetTokenEvent(
      GetTokenEvent event, Emitter<AuthenticationState> emit) {}
}
