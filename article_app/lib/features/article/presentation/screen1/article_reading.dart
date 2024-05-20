import 'dart:developer';

import 'package:article_app/features/article/presentation/Article_bloc/article_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_event.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_state.dart';
import 'package:article_app/features/article/presentation/Article_bloc/bookmark_bloc.dart';
import 'package:article_app/features/article/presentation/widgets/author_card.dart';
import 'package:article_app/features/article/presentation/widgets/gradient_scroll_view.dart';
import 'package:article_app/features/article/presentation/widgets/like_button.dart';
import 'package:article_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../domain/entities/article.dart';

class ArticleReading extends StatelessWidget {
  final Article article;

  const ArticleReading({super.key, required this.article});

  bool _isBookmarked(List<Article> bookmarks) {
    return bookmarks.any((element) => element.id == article.id);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticleBloc>(
          create: (_) => serviceLocator<ArticleBloc>(),
        ),
        BlocProvider(
          create: (_) =>
              serviceLocator<BookmarkBloc>()..add(LoadBookmarksEvent()),
        ),
      ],

      //
      child: BlocListener<ArticleBloc, ArticleState>(
        listener: (context, state) {
          if (state is ArticleFailureState) {
            log("error");
          } else if (state is ArticleDeletedState) {
            context.pop();
          }
        },

        //
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,
            actions: [
              BlocBuilder<ArticleBloc, ArticleState>(
                builder: (context, state) {
                  return _buildActions(context);
                },
              ),
            ],
          ),

          // body
          body: _buildBody(context),

          // Like button
          floatingActionButton: Transform.translate(
            offset: Offset(-20.w, -20.w),
            child: const LikeButton(likeCount: 2100),
          ),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 'Edit') {
          context.push(Routes.editArticle, extra: article);
        } else if (value == 'Delete') {
          BlocProvider.of<ArticleBloc>(context).add(
            DeletedArticleEvent(article.id),
          );
        }
      },
      icon: const Icon(
        Icons.more_horiz,
        color: AppColors.darkerBlue,
      ),
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: 'Edit',
            child: Text('Edit'),
          ),
          const PopupMenuItem(
            value: 'Delete',
            child: Text('Delete'),
          ),
        ];
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return GradientScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Article title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.title,
                    style: Theme.of(context).textTheme.titleLarge),

                SizedBox(height: 35.h),

                // Author card
                BlocConsumer<BookmarkBloc, BookmarkState>(
                  listener: (context, state) {
                    if (state is BookmarkErrorState) {
                      log("message");
                    } else if (state is BookmarkAddedState) {
                      log("message");
                      context.read<BookmarkBloc>().add(LoadBookmarksEvent());
                    } else if (state is BookmarkRemovedState) {
                      log("message");
                      context.read<BookmarkBloc>().add(LoadBookmarksEvent());
                    }
                  },

                  //
                  builder: (context, state) {
                    if (state is BookmarkLoadedState) {
                      return AuthorCard(
                        article: article,
                        isBookmarked: _isBookmarked(state.articles),
                      );
                    } else {
                      return AuthorCard(article: article, isBookmarked: false);
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),

          // Article image

          // Article content

          SizedBox(height: 100.h)
        ]),
      ),
    );
  }
}
