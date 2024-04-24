import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/auth/domain/entites/auth.dart';
import 'package:article_app/features/auth/domain/entites/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthEntity>> login(AuthenticationEntites loginEntity);

  Future<Either<Failure, AuthEntity>> signup(
      AuthenticationEntites signoutEntity);
  Future<Either<Failure, String>> getToken();
}
