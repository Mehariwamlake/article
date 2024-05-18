import 'package:article_app/features/article/domain/usecases/get_article_by_id.dart';
import 'package:article_app/features/article/domain/usecases/post_article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'article_event.dart';
import 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticleById _getArticle;
  final PostArticle _postArticle;

  ArticleBloc(
      {required GetArticleById getArticle, required PostArticle postArticle})
      : _getArticle = getArticle,
        _postArticle = postArticle,
        super(ArticleInitialState()) {
    on<GetArticleEvent>((event, emit) async {
      emit(ArticleLoadingState());

      final result = await _getArticle.call(event.articleId);

      result.fold(
        (failure) => emit(ArticleFailureState(error: failure.toString())),
        (article) => emit(ArticleSuccessState(article)),
      );
    });

    on<PostArticleEvent>((event, emit) async {
      emit(ArticleLoadingState());
      final result = await _postArticle.call(event.article);

      result.fold(
        (failure) => emit(ArticleFailureState(error: failure.toString())),
        (article) => emit(ArticleSuccessState(article)),
      );
    });
  }
}
