import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/user/domain/entites/user_data.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUserData();
}
