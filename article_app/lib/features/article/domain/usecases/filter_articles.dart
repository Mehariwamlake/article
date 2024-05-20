import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/domain/entities/tag.dart';
import 'package:article_app/features/article/domain/repositories/article_repository.dart';
import 'package:article_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FilterArticle implements UseCase<List<Article>, FilterParams> {
  final ArticleRepository repository;

  FilterArticle(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(FilterParams params) async {
    return await repository.filterArticles(params.tag, params.title);
  }
}

class FilterParams extends Equatable {
  final Tag tag;
  final String title;

  const FilterParams({required this.tag, required this.title});

  @override
  List<Object?> get props => [tag, title];
}
