import 'package:article_app/core/network/custom_client.dart';
import 'package:article_app/core/network/network_info.dart';
import 'package:article_app/features/auth/data/data_source/auth_remote.dart';
import 'package:article_app/features/auth/data/data_source/local_data_source.dart';
import 'package:article_app/features/auth/data/data_source/local_data_source_impl.dart';
import 'package:article_app/features/auth/data/data_source/remote_data_source.dart';
import 'package:article_app/features/auth/data/repository/auth_repo.dart';
import 'package:article_app/features/auth/domain/repository/auth_repository.dart';
import 'package:article_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:article_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton(
    () => GetTokenUseCase(authRepository: serviceLocator()),
  );

  // Core
  serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(serviceLocator()));
  serviceLocator.registerLazySingleton<CustomClient>(
    () => CustomClient(
      serviceLocator(),
      apiBaseUrl: '',
    ),
  );

  // Repository

  // Data sources

  // Feature-Authentication
  //! Bloc
  serviceLocator.registerFactory(
    () => AuthBloc(
      getTokenUsecase: serviceLocator(),
      loginUseCase: serviceLocator(),
      signUpUseCase: serviceLocator(),
      customClient: serviceLocator(),
    ),
  );

  //! Use cases
  serviceLocator.registerLazySingleton(
    () => LoginUseCase(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => SignUpUseCase(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => LogoutUseCase(
      authRepository: serviceLocator(),
    ),
  );

  //! Repository
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: serviceLocator(),
      authLocalDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  //! Data sources
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
  serviceLocator.registerLazySingleton(() => http.Client());
}
