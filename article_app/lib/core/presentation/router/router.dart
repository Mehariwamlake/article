import 'package:article_app/features/auth/presentation/pages/auth_page.dart';
import 'package:article_app/features/user/presentation/screen/user_profile.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

final GoRouter router = GoRouter(
  // TODO: Add all routes here

  routes: <RouteBase>[
    // Debug area

    // auth
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const UserProfile(),
    ),

    // article
    GoRoute(
      path: Routes.articles,
      builder: (context, state) => const AuthPage(),
    ),
  ],
);
