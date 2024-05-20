import 'dart:convert';
import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/core/network/custom_client.dart';
import 'package:article_app/features/article/data/models/create_article_dto.dart';
import 'package:article_app/features/article/data/models/tag_model.dart';
import 'package:article_app/features/article/domain/entities/tag.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../models/article_model.dart';

abstract class ArticleRemoteDataSource {
  Future<ArticleModel> getArticleById(String articleId);

  Future<ArticleModel> postArticle(ArticleModel article);

  Future<ArticleModel> updateArticle(ArticleModel article);

  Future<ArticleModel> deleteArticleById(String articleId);

  Future<List<ArticleModel>> getAllArticles();

  Future<List<ArticleModel>> filterArticles(Tag tag, String title);
  Future<List<TagModel>> getTags();
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final CustomClient client;
  final http.Client client1;

  ArticleRemoteDataSourceImpl({required this.client, required this.client1});

  final String baseUrl = "https://mock.apidog.com/m1/524680-485106-default";

  @override
  Future<ArticleModel> getArticleById(String articleId) async {
    final url = Uri.parse("$baseUrl/articles");
    final response = await client.get('${url}/$articleId');

    if (response.statusCode == 200) {
      return ArticleModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ArticleModel>> getAllArticles() async {
    final response = await client.get('$baseUrl/article');

    if (response.statusCode == 200) {
      final responsebody = json.decode(response.body);
      final List<dynamic> articleJsonList = responsebody["articles"];
      return articleJsonList
          .map((articleJson) => ArticleModel.fromJson(articleJson))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ArticleModel> postArticle(ArticleModel article) async {
    final dto = CreateUpdateArticleDto(
      content: article.content,
      title: article.title,
      photoPath: article.photoUrl,
      tags: article.tags.map<String>((e) => e.name).toList(),
      subtitle: article.subtitle,
    );

    StreamedResponse response;

    response = await client.multipartRequest(
      '$baseUrl/article/post',
      method: "POST",
      body: dto.toJson(),
    );

    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      final decode = jsonDecode(data);
      final articleModel = ArticleModel.fromJson(decode);
      return articleModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ArticleModel> updateArticle(ArticleModel article) async {
    final dto = CreateUpdateArticleDto(
      content: article.content,
      title: article.title,
      photoPath: article.photoUrl,
      tags: article.tags.map<String>((e) => e.name).toList(),
      subtitle: article.subtitle,
    );
    StreamedResponse response;

    response = await client.multipartRequest(
        '$baseUrl/article/update/${article.id}',
        method: "PUT",
        body: dto.toJson());

    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      final decode = jsonDecode(data);
      final articleModel = ArticleModel.fromJson(decode);
      return articleModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ArticleModel> deleteArticleById(String articleId) async {
    final response = await client.delete('article/delete/${articleId}');

    if (response.statusCode == 200) {
      return ArticleModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ArticleModel>> filterArticles(Tag tag, String title) async {
    final response = await client.get("$baseUrl/article",
        queryParams: {'tags': tag.name, 'searchParams': title});

    if (response.statusCode == 200) {
      final responsebody = json.decode(response.body);
      final List<dynamic> articleJsonList = responsebody["articles"];
      return articleJsonList
          .map((articleJson) => ArticleModel.fromJson(articleJson))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TagModel>> getTags() async {
    final response = await client.get('$baseUrl/tags');

    if (response.statusCode == 200) {
      final responsebody = json.decode(response.body);

      if (responsebody != null && responsebody["tags"] != null) {
        final List<dynamic> tagJsonList = responsebody["tags"];
        return tagJsonList
            .map<TagModel>((tagName) => TagModel(name: tagName))
            .toList();
      } else {
        // Handle the case where the "tags" key is missing or null in the response body
        throw ServerException();
      }
    } else {
      // Handle non-200 status codes
      throw ServerException();
    }
  }
}
