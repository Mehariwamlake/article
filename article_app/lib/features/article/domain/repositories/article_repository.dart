import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/article/domain/entities/tag.dart';

import '../entities/article.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepository {
  Future<Either<Failure, Article>> getArticleById(String articleId);
  Future<Either<Failure, List<Article>>> getAllArticles();
  Future<Either<Failure, Article>> postArticle(Article article);
  Future<Either<Failure, Article>> updateArticle(Article article);
  Future<Either<Failure, Article>> deletedArticleById(String articleId);
  Future<Either<Failure, List<Tag>>> getTags();
  Future<Either<Failure, List<Article>>> filterArticles(Tag tag, String title);

  Future<Either<Failure, List<Article>>> getBookmarkedArticles();
  Future<Either<Failure, Article>> addToBookmark(Article article);
  Future<Either<Failure, Article>> removeFromBookmark(String bookmarkid);
}
