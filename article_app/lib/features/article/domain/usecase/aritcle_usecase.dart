import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/usecases/usecase.dart';
import 'package:article_app/features/article/domain/entities/aritcle.dart';
import 'package:article_app/features/article/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class GetArticles {
  final ArticleRepository repository;
  GetArticles({required this.repository});

  Future<Either<Failure, List<Article>>> call(NoParams params) async {
    return await repository.getArticles();
  }
}

class GetArticleById {
  final ArticleRepository repository;
  GetArticleById({required this.repository});

  Future<Either<Failure, Article>> call(String id) async {
    return await repository.getArticleById(id);
  }
}

class DeleteArticle {
  final ArticleRepository repository;
  DeleteArticle({required this.repository});

  Future<Either<Failure, Article>> call(String id) async {
    return await repository.deleteArticle(id);
  }
}

class GetArticlesByUserId {
  final ArticleRepository repository;
  GetArticlesByUserId({required this.repository});

  Future<Either<Failure, List<Article>>> call(String userId) async {
    return await repository.getArticlesByUserId(userId);
  }
}

class PostArticle {
  final ArticleRepository repository;
  PostArticle({required this.repository});

  Future<Either<Failure, Article>> call(Article article) async {
    return await repository.postArticle(article);
  }
}

class UpdateArticle {
  final ArticleRepository repository;
  UpdateArticle({required this.repository});

  Future<Either<Failure, Article>> call(String id, Article article) async {
    return await repository.updateArticle(id, article);
  }
}
