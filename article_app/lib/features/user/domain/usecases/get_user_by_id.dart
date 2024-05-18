import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/usecases/usecase.dart';
import 'package:article_app/features/user/domain/entities/user.dart';
import 'package:article_app/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class GetUserById extends UseCase<User, String> {
  final UserRepository? repository;

  GetUserById(this.repository);

  @override
  Future<Either<Failure, User>> call(String userId) async {
    return await repository!.getUserById(userId);
  }
}

