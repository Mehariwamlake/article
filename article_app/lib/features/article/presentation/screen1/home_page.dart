import 'package:article_app/core/presentation/router/routes.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/tag_bloc.dart';
import 'package:article_app/features/article/presentation/Feed_bloc/feed_bloc.dart';
import 'package:article_app/features/article/presentation/widget1/homepagebody.dart';
import 'package:article_app/features/article/presentation/widgets/app_bar.dart';
import 'package:article_app/features/article/presentation/widgets/profile_avatar.dart';
import 'package:article_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:article_app/injection.dart';
import 'package:article_app/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedBloc>(
          create: (_) => serviceLocator<FeedBloc>()..add(GetAllArticlesEvent()),
        ),
        BlocProvider(
          create: (context) => serviceLocator<UserBloc>(),
        ),
      ],
      child: Scaffold(
          appBar: CustomAppBar(
            leading: SvgPicture.asset(
              "assets/svg/menu.svg",
              fit: BoxFit.scaleDown,
            ),
            title: 'Welcome Back!',
            actions: [
              GestureDetector(
                onTap: () {
                  context.push(Routes.profileScreen);
                },
                child: ProfileAvatar(
                  image:
                      "https://images.unsplash.com/photo-1554080353-a576cf803bda?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cGhvdG98ZW58MHx8MHx8fDA%3D",
                ),
              )
            ],
          ),
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    serviceLocator<TagBloc>()..add(LoadAllTagsEvent()),
              ),
              BlocProvider(
                create: (context) => serviceLocator<ArticleBloc>(),
              ),
              BlocProvider(
                create: (context) =>
                    serviceLocator<FeedBloc>()..add(GetAllArticlesEvent()),
                child: Container(),
              )
            ],
            child: BlocBuilder<FeedBloc, FeedState>(
              builder: (context, state) {
                if (state is LoadedFeedState) {
                  return HomeBody(
                    articles: state.articles,
                  );
                }
                return Container();
              },
            ),
          )),
    );
  }
}
