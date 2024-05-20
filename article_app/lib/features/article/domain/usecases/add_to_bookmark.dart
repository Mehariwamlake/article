import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/domain/repositories/article_repository.dart';
import 'package:article_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddToBookMark extends UseCase<Article, AddToBookMarkParams> {
  final ArticleRepository _articleRepository;

  AddToBookMark(this._articleRepository);
  @override
  Future<Either<Failure, Article>> call(AddToBookMarkParams params) async {
    return await _articleRepository.addToBookmark(params.article);
  }
}

class AddToBookMarkParams extends Equatable {
  final Article article;

  const AddToBookMarkParams({required this.article});

  @override
  List<Object?> get props => [article];
}
