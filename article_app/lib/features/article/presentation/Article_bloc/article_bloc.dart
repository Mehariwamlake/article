import 'package:article_app/features/article/domain/usecases/delete_article.dart';
import 'package:article_app/features/article/domain/usecases/edit_article.dart';
import 'package:article_app/features/article/domain/usecases/filter_articles.dart';
import 'package:article_app/features/article/domain/usecases/get_article_by_id.dart';
import 'package:article_app/features/article/domain/usecases/post_article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'article_event.dart';
import 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final FilterArticle _filterArticle;
  final UpdateArticle _updateArticle;
  final GetArticleById _getArticle;
  final PostArticle _postArticle;
  final DeletedArticleById _deletedArticleById;

  ArticleBloc({
    required FilterArticle filterArticle,
    required GetArticleById getArticle,
    required PostArticle postArticle,
    required UpdateArticle updateArticle,
    required DeletedArticleById deletedArticleById,
  })  : _getArticle = getArticle,
        _filterArticle = filterArticle,
        _postArticle = postArticle,
        _updateArticle = updateArticle,
        _deletedArticleById = deletedArticleById,
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
        (article) => emit(ArticlePostedState(article)),
      );
    });

    on<UpdateArticleEvent>((event, emit) async {
      emit(ArticleLoadingState());
      final result = await _updateArticle.call(event.article);

      result.fold(
        (failure) => emit(ArticleFailureState(error: failure.toString())),
        (article) => emit(ArticleUpdatedState(article)),
      );
    });

    on<DeletedArticleEvent>((event, emit) async {
      emit(ArticleLoadingState());
      final result = await _deletedArticleById.call(event.id);

      result.fold(
        (failure) => emit(ArticleFailureState(error: failure.toString())),
        (article) => emit(ArticleSuccessState(article)),
      );
    });

    on<FilterArticleEvent>((event, emit) async {
      emit(ArticleLoadingState());
      final result =
          await _filterArticle.call(event.searchParams as FilterParams);

      result.fold(
        (failure) => emit(ArticleFailureState(error: failure.toString())),
        (article) => emit(ArticleFilteredState(article)),
      );
    });
  }
}
