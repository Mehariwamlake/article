import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/auth/domain/entites/authenticated_user_info.dart';
import 'package:article_app/features/auth/domain/entites/authentication_entity.dart';
import 'package:article_app/features/auth/domain/entites/login_entity.dart';
import 'package:article_app/features/auth/domain/entites/sign_up_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthenticationEntity>> login(
      LoginRequestEntity loginRequestEntity);
  Future<Either<Failure, AuthenticatedUserInfo>> signUp(
      SignUpEntity signUpEntity);

  Future<Either<Failure, void>> logout(String token);
  Future<Either<Failure, String>> getToken();
}