import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/domain/repositories/article_repository.dart';
import 'package:article_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:dartz/dartz.dart';

class RemoveFromBookmark implements UseCase<Article, String> {
  final ArticleRepository repository;
  RemoveFromBookmark(this.repository);

  @override
  Future<Either<Failure, Article>> call(String bookmarkid) async {
    return await repository.removeFromBookmark(bookmarkid);
  }
}
