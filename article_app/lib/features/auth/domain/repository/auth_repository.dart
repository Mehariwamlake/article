import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/auth/domain/entites/auth.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Authentication>> login(Authentication user);

  Future<Either<Failure, Authentication>> signup(Authentication newuser);
}