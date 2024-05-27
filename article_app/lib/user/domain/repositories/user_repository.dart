import 'package:article_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/user_data.dart';

abstract class UserRepository {
  Future<Either<Failure, UserData>> getUserData(String token);
  Future<Either<Failure, UserData>> updateUserPhoto(
      String token, String imagePath);
}
