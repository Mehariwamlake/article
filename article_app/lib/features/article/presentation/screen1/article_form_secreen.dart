import 'package:article_app/core/presentation/router/routes.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_state.dart';
import 'package:article_app/features/article/presentation/Article_bloc/tag_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/tag_selector_bloc.dart';
import 'package:article_app/features/article/presentation/Feed_bloc/feed_bloc.dart';
import 'package:article_app/features/article/presentation/widgets/create_article_form.dart';
import 'package:article_app/features/article/presentation/widgets/snackbar.dart';
import 'package:article_app/features/article/presentation/widgets/update_article_form.dart';
import 'package:article_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ArticleFormPage extends StatelessWidget {
  final Article? article;

  const ArticleFormPage({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Center(
          child: Text(article == null ? 'New article' : 'Edit article',
              style: Theme.of(context).textTheme.titleMedium),
        ),
      ),

      //
      body: MultiBlocProvider(
        providers: [
          BlocProvider<TagBloc>(
            create: (context) =>
                serviceLocator<TagBloc>()..add(LoadAllTagsEvent()),
          ),
          BlocProvider<ArticleBloc>(
              create: (context) => serviceLocator<ArticleBloc>()),
          BlocProvider<TagSelectorBloc>(
            create: (context) => serviceLocator<TagSelectorBloc>(),
          ),
        ],

        //
        child: BlocConsumer<ArticleBloc, ArticleState>(
          listener: (context, state) {
            if (state is ArticlePostedState) {
              showSuccess(context, 'Article created successfully');
              context.push(Routes.articleDetail, extra: state.article);
            }

            //
            else if (state is ArticleUpdatedState) {
              showSuccess(context, 'Article updated successfully');
              context.push(Routes.articleDetail, extra: state.article);
            }

            // Show error
            else if (state is ArticleFailureState) {
              showError(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is ArticleLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (article != null) {
              return UpdateArticleForm(article: article!);
            }

            return const CreateArticleForm();
          },
        ),
      ),
    );
  }
}
