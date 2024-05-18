import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/usecases/usecase.dart';
import 'package:article_app/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';


class DeleteUserById extends UseCase<void, String> {
  final UserRepository? repository;
  DeleteUserById(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository!.deleteUserById(id);
  }
}
