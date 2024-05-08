import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/usecases/usecase.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class GetArticleById implements UseCase<Article, String> {
  final ArticleRepository repository;
  GetArticleById(this.repository);

  @override
  Future<Either<Failure, Article>> call(String articleId) async {
    return await repository.getArticleById(articleId);
  }
}
