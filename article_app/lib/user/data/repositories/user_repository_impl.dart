import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_data.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_data_model.dart';

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
  Future<Either<Failure, UserData>> getUserData(String token) async {
    if (await networkInfo.isConnected) {
      final user = await remoteDataSource.getUserData(token);

      return Right(user);
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserData>> updateUserPhoto(
      String token, String imagePath) async {
    if (await networkInfo.isConnected) {
      try {
        final uploadedPhoto =
            await remoteDataSource.updateUserPhoto(token, imagePath);
        return Right(uploadedPhoto);
      } on ServerException {
        return Left(ServerFailure());
      } on NetworkException {
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
