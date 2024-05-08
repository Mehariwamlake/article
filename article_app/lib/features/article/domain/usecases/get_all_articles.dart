import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/usecases/usecase.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';


class GetAllArticles implements UseCase<List<Article>, NoParams> {
  final ArticleRepository repository;
  GetAllArticles(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(NoParams params) async {
    return await repository.getAllArticles();
  }
}