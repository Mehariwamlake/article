import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/usecases/usecase.dart';
import 'package:article_app/features/user/domain/entities/user.dart';
import 'package:article_app/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';


class EditUserById extends UseCase<User, User> {
  final UserRepository? repository;
  EditUserById(this.repository);

  @override
  Future<Either<Failure, User>> call(User user) async {
    return await repository!.editUserById(user);
  }
}
