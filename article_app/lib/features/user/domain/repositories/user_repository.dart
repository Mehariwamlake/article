import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/user/domain/entities/user.dart';
import 'package:dartz/dartz.dart';


abstract class UserRepository {

  Future<Either<Failure, User>> addUser(User user);
  Future<Either<Failure, User>> getUserById(String id);
  Future<Either<Failure, User>> editUserById(User user);
  Future<Either<Failure, void>> deleteUserById(String id);

}