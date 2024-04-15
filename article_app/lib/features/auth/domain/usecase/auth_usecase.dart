import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/usecases/usecase.dart';
import 'package:article_app/features/auth/domain/entites/auth.dart';
import 'package:article_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements UseCase<Authentication, Authentication> {
  final AuthenticationRepository repository;
  LoginUseCase(this.repository);
  @override
  Future<Either<Failure, Authentication>> call(Authentication payload) async {
    return await repository.login(payload);
  }
}



class SignupUseCase implements UseCase<Authentication, Authentication> {
  final AuthenticationRepository repository;
  SignupUseCase(this.repository);
  @override
  Future<Either<Failure, Authentication>> call(Authentication payload) async {
    return await repository.signup(payload);
  }
}