import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/auth/data/data_source/local_data_source.dart';
import 'package:article_app/features/auth/data/data_source/remote_data_source.dart';
import 'package:article_app/features/auth/domain/entites/authenticated_user_info.dart';
import 'package:article_app/features/auth/domain/entites/authentication_entity.dart';
import 'package:article_app/features/auth/domain/entites/login_entity.dart';
import 'package:article_app/features/auth/domain/entites/sign_up_entity.dart';
import 'package:article_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/network_info.dart';

import '../models/authenticated_user_info_model.dart';
import '../models/login_model.dart';
import '../models/sign_up_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.authLocalDataSource,
      required this.authRemoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = await authLocalDataSource.getToken();
      return Right(token);
    } on CacheException catch (e) {
      // print the error message for debugging
      debugPrint(e.toString());
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticationEntity>> login(
      LoginRequestEntity loginRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final LoginRequestModel loginRequestModel = LoginRequestModel(
            email: loginRequestEntity.email,
            password: loginRequestEntity.password);
        final authenticationEntity =
            await authRemoteDataSource.login(loginRequestModel);

        await authLocalDataSource.cacheToken(authenticationEntity.token);

        return Right(authenticationEntity);
      } on ServerException catch (e) {
        // print the error message for debugging
        debugPrint(e.toString());
        return Left(ServerFailure());
      } on LoginException catch (e) {
        // print the error message for debugging
        debugPrint(e.toString());

        return Left(LoginFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticatedUserInfo>> signUp(
      SignUpEntity signUpEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final SignUpRequestModel signUpRequestModel = SignUpRequestModel(
            email: signUpEntity.email,
            password: signUpEntity.password,
            fullName: signUpEntity.fullName,
            expertise: signUpEntity.expertise,
            bio: signUpEntity.bio);
        final authenticatedUserInfo =
            await authRemoteDataSource.signUp(signUpRequestModel);
        return Right(authenticatedUserInfo);
      } on ServerException catch (e) {
        // print the error message for debugging
        debugPrint(e.toString());
        return Left(ServerFailure());
      } on SignUpException catch (e) {
        // print the error message for debugging
        debugPrint(e.toString());
        return Left(SignUpFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout(String token) async {
    try {
      await authLocalDataSource.removeToken();
      await authLocalDataSource.deleteLoggedInUser();
      return const Right(null);
    } on ServerException catch (e) {
      // print the error message for debugging
      debugPrint(e.toString());
      return Left(ServerFailure());
    } on LogoutException catch (e) {
      // print the error message for debugging
      debugPrint(e.toString());
      return Left(LogoutFailure());
    }
  }
}
