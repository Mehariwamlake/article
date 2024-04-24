import 'package:article_app/core/network/network_info.dart';
import 'package:article_app/features/auth/data/data_source/auth_remote.dart';
import 'package:article_app/features/auth/data/data_source/local_data_source.dart';
import 'package:article_app/features/auth/data/repository/auth_repo.dart';
import 'package:article_app/features/auth/domain/repository/auth_repository.dart';
import 'package:article_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:article_app/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;
Future<void> init() async {

serviceLocator.registerFactory(
    () => AuthenticationBloc(
      getTokenUsecase: serviceLocator(),
      loginUseCase: serviceLocator(),
      signupUseCase: serviceLocator(),
      customClient: serviceLocator(),
    ),
  );

  //! Use cases
  serviceLocator.registerLazySingleton(
    () => LoginUseCase(
      AuthenticationRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => SignupUseCase(
      authRepository: serviceLocator(),
    ),
  );



  //! Repository
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      auth: serviceLocator(),
      authLocalDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  //! Data sources
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSoureceImpl(
      client: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthRemoteDataSoureceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
  serviceLocator.registerLazySingleton(() => http.Client());
}