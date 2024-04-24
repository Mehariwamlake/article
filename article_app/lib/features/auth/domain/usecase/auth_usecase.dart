import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/usecases/usecase.dart';
import 'package:article_app/features/auth/domain/entites/auth.dart';
import 'package:article_app/features/auth/domain/entites/auth_entity.dart';
import 'package:article_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements UseCase<AuthEntity, AuthenticationEntites> {
  final AuthenticationRepository repository;
  LoginUseCase(this.repository);
  @override
  Future<Either<Failure, AuthEntity>> call(
      AuthenticationEntites payload) async {
    return await repository.login(payload);
  }
}

class SignupUseCase implements UseCase<AuthEntity, AuthenticationEntites> {
  final AuthenticationRepository repository;
  SignupUseCase(this.repository);
  @override
  Future<Either<Failure, AuthEntity>> call(
      AuthenticationEntites payload) async {
    return await repository.signup(payload);
  }

  
}

class GetTokenUseCase extends UseCase<void, NoParams> {
  final AuthenticationRepository authRepository;

  GetTokenUseCase({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.getToken();
  }
}