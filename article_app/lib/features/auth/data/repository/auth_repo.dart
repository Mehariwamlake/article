import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/network/network_info.dart';
import 'package:article_app/features/auth/data/data_source/auth_remote.dart';
import 'package:article_app/features/auth/domain/entites/auth.dart';
import 'package:article_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Authentication>> login(Authentication user) async {
    try {
      final response = await remoteDataSource.login(user);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure("Internal Server Error."));
    }
  }

  @override
  Future<Either<Failure, Authentication>> signup(Authentication newuser) async {
    // TODO: implement signup
    try {
      final response = await remoteDataSource.signup(newuser);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure("Internal Server Error."));
    }
  }
}
