import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/domain/entities/tag.dart';
import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class GetArticleEvent extends ArticleEvent {
  final String articleId;

  const GetArticleEvent({required this.articleId});

  @override
  List<Object> get props => [articleId];
}

class PostArticleEvent extends ArticleEvent {
  final Article article;

  const PostArticleEvent({required this.article});

  @override
  List<Object?> get props => [article];
}

class UpdateArticleEvent extends ArticleEvent {
  
  final Article article;

  const UpdateArticleEvent({ required this.article});

  @override
  List<Object> get props => [article];
}

class DeletedArticleEvent extends ArticleEvent {
  final String id;

  const DeletedArticleEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class FilterArticleEvent extends ArticleEvent {
  final Tag tag;
  final String searchParams;

  const FilterArticleEvent(this.tag, this.searchParams);

  @override
  List<Object?> get props => [tag, searchParams];
}
