import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/article/data/datasources/article_remote_data_source.dart';
import 'package:article_app/features/article/data/models/article_model.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/domain/repositories/article_repository.dart';
import 'package:article_app/features/article/domain/usecases/post_article.dart';
import 'package:dartz/dartz.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;

  ArticleRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Article>> getArticleById(String articleId) async {
    try {
      final remoteArticle = await remoteDataSource.getArticleById(articleId);
      // Cache the article locally

      return Right(remoteArticle);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getAllArticles() async {
    try {
      final remoteArticles = await remoteDataSource.getAllArticles();
      // Cache the articles locally
      return Right(remoteArticles);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Article>> postArticle(Article article) async {
    try {
      final ArticleModel articleModel = ArticleModel(
        content: article.content,
        id: article.id,
        date: article.date,
        likesCount: article.likesCount,
        subtitle: article.subtitle,
        tags: article.tags,
        title: article.title,
      );
      final remoteArticles = await remoteDataSource.postArticle(articleModel);
      // Cache the articles locally
      return Right(remoteArticles);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Article>> updateArticle(Article article) {
    // TODO: implement updateArticle
    throw UnimplementedError();
  }
}
