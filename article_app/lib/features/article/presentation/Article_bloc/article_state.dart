import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:equatable/equatable.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();
}

class ArticleInitialState extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoadingState extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleSuccessState extends ArticleState {
  final Article article;

  const ArticleSuccessState(this.article);

  @override
  List<Object> get props => [article];
}

class ArticleFailureState extends ArticleState {
  final String error;

  const ArticleFailureState({required this.error});

  @override
  List<Object> get props => [error];
}

class ArticleDeletedState extends ArticleState {
  final Article article;

  const ArticleDeletedState(this.article);

  @override
  List<Object> get props => [article];
}

class ArticleFilteredState extends ArticleState {
  final List<Article> articles;

  const ArticleFilteredState(this.articles);

  @override
  List<Object> get props => [articles];
}

final class ArticleUpdatedState extends ArticleState {
  final Article article;

  const ArticleUpdatedState(this.article);

  @override
  List<Object> get props => [article];
}

final class ArticlePostedState extends ArticleState {
  final Article article;

  const ArticlePostedState(this.article);

  @override
  List<Object> get props => [article];
}
