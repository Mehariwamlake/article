import 'package:article_app/core/errors/failures.dart';

import '../entities/article.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepository {
  Future<Either<Failure,Article>> getArticleById(String articleId);
  Future<Either<Failure, List<Article>>> getAllArticles();
  Future<Either<Failure, Article>> postArticle(Article article);
  Future<Either<Failure, Article>> updateArticle(Article article);
}