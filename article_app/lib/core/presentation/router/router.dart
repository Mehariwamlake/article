import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/screen1/article_detail.dart';
import 'package:article_app/features/article/presentation/screen1/article_reading.dart';
import 'package:article_app/features/article/presentation/screen1/home_page.dart';
import 'package:article_app/features/article/presentation/widgets/article_detail.dart';
import 'package:article_app/features/auth/presentation/pages/auth_page.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

final GoRouter router = GoRouter(
  // TODO: Add all routes here

  routes: <RouteBase>[
    // Debug area

    // auth
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        return ArticlePage();
      },
    ),

    // article
    // GoRoute(
    // path: Routes.articles,
    // builder: (context, state) => const ArticlePage(),
    // ),

    GoRoute(
      path: Routes.articleDetail,
      builder: (context, state) {
        final article = state.extra as Article;
        return ArticleReading(article: article);
      },
    ),
  ],
);
