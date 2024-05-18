import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class GetArticleEvent extends ArticleEvent {
  final String articleId;

  GetArticleEvent({required this.articleId});

  @override
  List<Object> get props => [articleId];
}

class PostArticleEvent extends ArticleEvent {
  final Article article;

  PostArticleEvent({required this.article});

  @override
  // TODO: implement props
  List<Object?> get props => [article];
}
