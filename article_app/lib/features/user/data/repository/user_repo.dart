import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/network/network_info.dart';
import 'package:article_app/features/user/data/data_source/user_local.dart';
import 'package:article_app/features/user/data/data_source/user_remote.dart';
import 'package:article_app/features/user/data/model/user_model.dart';
import 'package:article_app/features/user/domain/entites/user_data.dart';
import 'package:article_app/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRespositoryImpl extends UserRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRespositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.getUserData();

        await localDataSource.cacheUserData(user);
        return Right(user.toEntity());
      } catch (e) {
        try {
          final user = await localDataSource.getUserData();
          return Right(user);
        } catch (e) {
          return Left(CacheFailure());
        }
      }
    } else {
      try {
        final user = await localDataSource.getUserData();
        return Right(user);
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }
}
