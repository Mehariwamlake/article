import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/user/domain/entites/user_data.dart';
import 'package:article_app/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserData {
  final UserRepository userRepository;

  GetUserData(this.userRepository);

  Future<Either<Failure, UserEntity>> getUserData() {
    return userRepository.getUserData();
  }

  void fold(void Function(dynamic failure) param0, void Function(dynamic user) param1) {}
}
