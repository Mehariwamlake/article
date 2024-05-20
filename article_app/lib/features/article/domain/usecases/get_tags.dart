import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/usecases/usecase.dart';
import 'package:article_app/features/article/domain/entities/tag.dart';
import 'package:article_app/features/article/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class GetTags implements UseCase<List<Tag>, NoParams> {
  final ArticleRepository repository;

  GetTags(this.repository);

  @override
  Future<Either<Failure, List<Tag>>> call(NoParams params) async {
    return await repository.getTags();
  }
}
