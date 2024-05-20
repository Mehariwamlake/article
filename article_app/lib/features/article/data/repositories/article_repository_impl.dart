import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/article/data/datasources/article_local_data_source.dart';
import 'package:article_app/features/article/data/datasources/article_remote_data_source.dart';
import 'package:article_app/features/article/data/models/article_mapper.dart';
import 'package:article_app/features/article/data/models/article_model.dart';
import 'package:article_app/features/article/data/models/create_article_dto.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/domain/entities/tag.dart';
import 'package:article_app/features/article/domain/repositories/article_repository.dart';
import 'package:article_app/features/article/domain/usecases/post_article.dart';
import 'package:dartz/dartz.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;
  final ArticleLocalDataSource localDataSource;

  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
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
      await localDataSource.cacheArticles(remoteArticles);
      return Right(remoteArticles);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Article>> postArticle(Article article) async {
    try {
      final remoteArticles =
          await remoteDataSource.postArticle(article.toArticleModel());
      // Cache the articles locally
      return Right(remoteArticles);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Article>> updateArticle(Article article) async {
    try {
      final remoteArticles =
          await remoteDataSource.updateArticle(article.toArticleModel());
      // Cache the articles locally
      return Right(remoteArticles);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Article>> deletedArticleById(String articleId) async {
    try {
      final remoteArticles =
          await remoteDataSource.deleteArticleById(articleId);
      // Cache the articles locally
      return Right(remoteArticles);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Article>> addToBookmark(Article article) async {
    await localDataSource.addToBookmark(article.toArticleModel());
    return Right(article);
  }

  @override
  Future<Either<Failure, List<Article>>> filterArticles(
      Tag tag, String title) async {
    try {
      final remoteArticles = await remoteDataSource.filterArticles(tag, title);
      await localDataSource.getArticles();
      // Cache the articles locally
      return Right(remoteArticles);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getBookmarkedArticles() async {
    final articles = await localDataSource.getBookmarkedArticles();
    return Right(articles);
  }

  @override
  Future<Either<Failure, List<Tag>>> getTags() async {
    try {
      final tags = await remoteDataSource.getTags();
      // Cache the articles locally
      await localDataSource.cacheTags(tags);
      return Right(tags);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Article>> removeFromBookmark(String articleId) async {
    final article = await localDataSource.removeFromBookmark(articleId);
    return Right(article);
  }
}
