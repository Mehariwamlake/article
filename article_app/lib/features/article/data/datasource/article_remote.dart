import 'dart:convert';

import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/features/article/data/models/article_model.dart';
import 'package:article_app/features/article/domain/entities/aritcle.dart';
import 'package:http/http.dart' as http;

abstract class ArticleRemoteDataSource {
  Future<ArticleModel> deleteArticle(String id);
  Future<ArticleModel> getArticleById(String id);
  Future<List<ArticleModel>> getArticle();
  Future<List<ArticleModel>> getArticlesByUserId(String userid);
  Future<ArticleModel> postArticle(Article article);
  Future<ArticleModel> updateArticle(String id, Article article);
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final http.Client client;
  final urlString =
      'https://66201f593bf790e070af11c1.mockapi.io/article/article';

  ArticleRemoteDataSourceImpl({required this.client});

  @override
  Future<ArticleModel> getArticleById(String id) async {
    final response = await client.get(
      Uri.parse('$urlString$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return ArticleModel.fromJson(jsonResponse);
    } else {
      throw ServerException('Internal Server Failure');
    }
  }

  @override
  Future<List<ArticleModel>> getArticlesByUserId(String userid) {
    // TODO: implement GetArticlesByUserId
    throw UnimplementedError();
  }

  @override
  Future<ArticleModel> deleteArticle(String id) {
    // TODO: implement deleteArticle
    throw UnimplementedError();
  }

  @override
  Future<List<ArticleModel>> getArticle() async {
    final response = await client.get(
      Uri.parse(urlString),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final articlesList = List<Map<String, dynamic>>.from(jsonResponse);
      final articles =
          articlesList.map((json) => ArticleModel.fromJson(json)).toList();
      return articles;
    } else {
      throw ServerException('Internal Server Error');
    }
  }

  @override
  Future<ArticleModel> postArticle(Article article) async {
    final articleModel = ArticleModel(
      id: article.id,
      title: article.title,
      subtitle: article.subtitle,
      description: article.description,
      postedBy: article.postedBy,
      publishedDate: article.publishedDate,
      tag: article.tag,
      imageUrl: article.imageUrl,
      likeCount: article.likeCount,
      timeEstimate: article.timeEstimate,
    );

    final jsonBody = json.encode(articleModel.toJson());
    final response = await client.post(
      Uri.parse('${urlString}postArticle'),
      body: jsonBody,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return ArticleModel.fromJson(jsonResponse);
    } else {
      throw ServerException('Internal Server Failure');
    }
  }

  @override
  Future<ArticleModel> updateArticle(String id, Article article) async {
    final articleModel = ArticleModel(
      id: article.id,
      title: article.title,
      subtitle: article.subtitle,
      description: article.description,
      postedBy: article.postedBy,
      publishedDate: article.publishedDate,
      tag: article.tag,
      imageUrl: article.imageUrl,
      likeCount: article.likeCount,
      timeEstimate: article.timeEstimate,
    );
    final jsonBody = json.encode(articleModel.toJson());
    final response = await client.put(
      Uri.parse('${urlString}updateArticle/$id'),
      body: jsonBody,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return ArticleModel.fromJson(jsonResponse);
    } else {
      throw ServerException('Internal Server Failure');
    }
  }
}
