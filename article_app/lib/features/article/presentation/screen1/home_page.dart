import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_bloc.dart';
import 'package:article_app/features/article/presentation/Feed_bloc/feed_bloc.dart';
import 'package:article_app/features/article/presentation/widget1/homepagebody.dart';
import 'package:article_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:article_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticlePage extends StatelessWidget {
  
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedBloc>(
      create: (_) => serviceLocator<FeedBloc>()..add(GetAllArticlesEvent()),
      child: Scaffold(
          appBar: AppBar(
            title: Text('wellcome'),
          ),
          body: BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              if (state is LoadedFeedState) {
                return HomeBody(
                  articles: state.articles,
                  
                );
              }
              return Container();
            },
          )),
    );
  }
}
