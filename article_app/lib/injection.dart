import 'package:article_app/core/network/network_info.dart';
import 'package:article_app/features/auth/data/data_source/auth_remote.dart';
import 'package:article_app/features/auth/data/repository/auth_repo.dart';
import 'package:article_app/features/auth/domain/repository/auth_repository.dart';
import 'package:article_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:article_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> inti() async {
  final sharedPreference = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreference);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//bloc
  sl.registerFactory(() => AuthenticationBloc(
        loginUseCase: sl(),
        signupUseCase: sl(),
      ));

// usecases

  sl.registerFactory(() => LoginUseCase(sl()));
  sl.registerFactory(() => SignupUseCase(sl()));

  sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSoureceImpl(client: sl()));
// user remote

// non constants
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
