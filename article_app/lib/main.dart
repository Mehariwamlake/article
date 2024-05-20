import 'package:article_app/bloc_observer.dart';
import 'package:article_app/core/presentation/router/router.dart';
import 'package:article_app/core/presentation/theme/app_theme.dart';

import 'package:article_app/features/article/presentation/Article_bloc/article_bloc.dart';

import 'package:article_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:flutter/material.dart';
import 'package:article_app/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  Bloc.observer = SimpleBlocObserver();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => di.serviceLocator<AuthBloc>()..add(GetTokenEvent()),
          ),
          BlocProvider<ArticleBloc>(
            create: (_) => di.serviceLocator<ArticleBloc>(),
          ),
        ],
        child: MaterialApp.router(
          title: 'Blog app',
          theme: AppTheme.themeData,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      ),
    );
  }
}
