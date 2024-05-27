import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/screen1/article_form_secreen.dart';
import 'package:article_app/features/article/presentation/screen1/article_reading.dart';
import 'package:article_app/features/article/presentation/screen1/home_page.dart';
import 'package:article_app/features/auth/presentation/pages/auth_page.dart';
import 'package:article_app/user/presentation/screens/user_profile.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

final GoRouter router = GoRouter(
  // TODO: Add all routes here

  routes: <RouteBase>[
    // Debug area
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const AuthPage(),
    ),
    // auth
    GoRoute(
      path: Routes.articles,
      builder: (context, state) {
        return ArticlePage();
      },
    ),

    GoRoute(
      path: Routes.articleDetail,
      builder: (context, state) {
        final article = state.extra as Article;
        return ArticleReading(article: article);
      },
    ),

    GoRoute(
      path: Routes.createArticle,
      builder: (context, state) {
        return const ArticleFormPage();
      },
    ),

    GoRoute(
      path: Routes.editArticle,
      builder: (context, state) {
        final article = state.extra as Article;
        return ArticleFormPage(article: article);
      },
    ),

    GoRoute(
      path: Routes.profileScreen,
      builder: (context, state) => const UserProfile(),
    ),
  ],
);
