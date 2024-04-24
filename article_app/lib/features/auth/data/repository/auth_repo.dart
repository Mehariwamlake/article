import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/network/network_info.dart';
import 'package:article_app/features/auth/data/data_source/auth_remote.dart';
import 'package:article_app/features/auth/data/data_source/local_data_source.dart';
import 'package:article_app/features/auth/data/models/auth_model.dart';
import 'package:article_app/features/auth/domain/entites/auth.dart';
import 'package:article_app/features/auth/domain/entites/auth_entity.dart';
import 'package:article_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl(
    this.authLocalDataSource, {
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthEntity>> login(
      AuthenticationEntites loginEntity) async {
    try {
      final AuthenticationModel authenticationModel = AuthenticationModel(
        password: loginEntity.password,
        userName: loginEntity.userName,
      );
      final response = await remoteDataSource.login(authenticationModel);
      return Right(response as AuthEntity);
    } on ServerException {
      return Left(ServerFailure("Internal Server Error."));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> signup(
      AuthenticationEntites signupEntity) async {
    // TODO: implement signup
    try {
      final AuthenticationModel authenticationModel = AuthenticationModel(
          password: signupEntity.password, userName: signupEntity.userName);
      final response = await remoteDataSource.signup(authenticationModel);
      return Right(response as AuthEntity);
    } on ServerException {
      return Left(ServerFailure("Internal Server Error."));
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = await authLocalDataSource.getToken();
      return Right(token);
    } on CacheException catch (e) {
      // print the error message for debugging
      debugPrint(e.toString());
      return Left(CacheFailure('error'));
    }
  }
}
