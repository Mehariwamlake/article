import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/article/domain/entities/aritcle.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getArticles();
  Future<Either<Failure, Article>> getArticleById(String id);
  Future<Either<Failure, List<Article>>> getArticlesByUserId(String userId);
  Future<Either<Failure, Article>> postArticle(Article article);
  Future<Either<Failure, Article>> updateArticle(String id, Article article);
  Future<Either<Failure, Article>> deleteArticle(String id);
}
