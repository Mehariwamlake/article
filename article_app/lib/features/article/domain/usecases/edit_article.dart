import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/usecases/usecase.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateArticle implements UseCase<Article, Article> {
  final ArticleRepository repository;

  UpdateArticle(this.repository);

  @override
  Future<Either<Failure, Article>> call(Article article) async {
    return await repository.updateArticle(article);
  }
}
