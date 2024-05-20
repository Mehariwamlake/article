import 'package:article_app/core/network/custom_client.dart';
import 'package:article_app/core/network/network_info.dart';
import 'package:article_app/features/article/data/datasources/article_local_data_source.dart';
import 'package:article_app/features/article/data/datasources/article_remote_data_source.dart';
import 'package:article_app/features/article/data/repositories/article_repository_impl.dart';
import 'package:article_app/features/article/domain/repositories/article_repository.dart';
import 'package:article_app/features/article/domain/usecases/add_to_bookmark.dart';
import 'package:article_app/features/article/domain/usecases/delete_article.dart';
import 'package:article_app/features/article/domain/usecases/delete_bookmark.dart';
import 'package:article_app/features/article/domain/usecases/edit_article.dart';
import 'package:article_app/features/article/domain/usecases/filter_articles.dart';
import 'package:article_app/features/article/domain/usecases/get_all_articles.dart';
import 'package:article_app/features/article/domain/usecases/get_article_by_id.dart';
import 'package:article_app/features/article/domain/usecases/get_tags.dart';
import 'package:article_app/features/article/domain/usecases/load_book_mark.dart';
import 'package:article_app/features/article/domain/usecases/post_article.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/bookmark_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/tag_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/tag_selector_bloc.dart';
import 'package:article_app/features/article/presentation/Feed_bloc/feed_bloc.dart';

import 'package:article_app/features/auth/data/data_source/auth_remote.dart';
import 'package:article_app/features/auth/data/data_source/local_data_source.dart';
import 'package:article_app/features/auth/data/data_source/local_data_source_impl.dart';
import 'package:article_app/features/auth/data/data_source/remote_data_source.dart';
import 'package:article_app/features/auth/data/repository/auth_repo.dart';
import 'package:article_app/features/auth/domain/repository/auth_repository.dart';
import 'package:article_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:article_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:article_app/features/user/data/datasources/user_remote_data_source.dart';
import 'package:article_app/features/user/data/repositories/user_repository_imp.dart';
import 'package:article_app/features/user/domain/repositories/user_repository.dart';

import 'package:article_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
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

  serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: serviceLocator(),
    ),
  );

  // Data sources

  serviceLocator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: serviceLocator()),
  );

  // Feature-Authentication
  //! Bloc

  serviceLocator.registerFactory(() => ArticleBloc(
        getArticle: serviceLocator(),
        postArticle: serviceLocator(),
        updateArticle: serviceLocator(),
        deletedArticleById: serviceLocator(),
        filterArticle: serviceLocator(),
      ));

  serviceLocator.registerFactory(() => TagSelectorBloc());

  serviceLocator
      .registerFactory(() => FeedBloc(getAllArticles: serviceLocator()));
  serviceLocator.registerFactory(() => TagBloc(getTags: serviceLocator()));

  serviceLocator.registerFactory(
    () => AuthBloc(
      getTokenUsecase: serviceLocator(),
      loginUseCase: serviceLocator(),
      signUpUseCase: serviceLocator(),
      customClient: serviceLocator(),
      logoutUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(() => UserBloc(
        getUser: serviceLocator(),
        addUser: serviceLocator(),
        getUserById: serviceLocator(),
        editUserById: serviceLocator(),
        deleteUserById: serviceLocator(),
      ));

  serviceLocator.registerFactory(() => BookmarkBloc(
        addToBookmark: serviceLocator(),
        removeFromBookmark: serviceLocator(),
        loadBookmarks: serviceLocator(),
      ));

  //! Use cases
  serviceLocator.registerLazySingleton(
    () => LoginUseCase(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(() => GetAllArticles(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetArticleById(serviceLocator()));
  serviceLocator.registerLazySingleton(() => PostArticle(serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateArticle(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => DeletedArticleById(serviceLocator()));
  serviceLocator.registerLazySingleton(() => FilterArticle(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetTags(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AddToBookMark(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => RemoveFromBookmark(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LoadBookmarks(serviceLocator()));

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

  serviceLocator.registerLazySingleton(
    () => GetTokenUseCase(authRepository: serviceLocator()),
  );

  //! Repository

  serviceLocator.registerLazySingleton<ArticleRepository>(() =>
      ArticleRepositoryImpl(
          remoteDataSource: serviceLocator(),
          localDataSource: serviceLocator()));
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: serviceLocator(),
      authLocalDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  //! Data sources

  serviceLocator.registerLazySingleton<ArticleRemoteDataSource>(
      () => ArticleRemoteDataSourceImpl(
            client: serviceLocator(),
            client1: serviceLocator(),
          ));

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

  serviceLocator.registerLazySingleton<ArticleLocalDataSource>(
    () => ArticleLocalDataSourceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );

  // External
  serviceLocator.registerLazySingleton(() => http.Client());

  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
