import 'package:article_app/features/auth/presentation/bloc/pages/auth_page.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

final GoRouter router = GoRouter(
  // TODO: Add all routes here

  routes: <RouteBase>[
    // Debug area

    // auth
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const AuthPage(),
    ),

    // article
  ],
);
