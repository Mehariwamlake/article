import 'dart:convert';

import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/features/article/data/datasources/article_remote_data_source.dart';
import 'package:article_app/features/article/data/models/article_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'article_remote_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ArticleRemoteDataSourceImpl remoteDataSourceImpl;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    remoteDataSourceImpl = ArticleRemoteDataSourceImpl(client: mockClient, client1: mockClient);
  });

  group(
    "getArticles",
    () {
      final fixtureData = fixture('article_cached.json');
      final sampleResponse = json.decode(fixtureData);

      final articlesList = List<Map<String, dynamic>>.from(sampleResponse);
      final tArticleModels = articlesList
          .map((jsonInstance) => ArticleModel.fromJson(jsonInstance))
          .toList();
      test(
        "should perform a get request on a URL with application/json header",
        () async {
          when(mockClient.get(any, headers: anyNamed('headers')))
              .thenAnswer((_) async => http.Response(fixtureData, 200));

          final response = await remoteDataSourceImpl.getArticle();
          expect(response, equals(tArticleModels));

          verify(
            mockClient.get(
              Uri.parse(
                  'https://66201f593bf790e070af11c1.mockapi.io/article/article'),
              headers: {'Content-Type': 'application/json'},
            ),
          );
        },
      );
    },
  );

  //   //  Update Article
  group(
    "updateArticle",
    () {
      final fixtureData = fixture('article.json');
      final sampleResponse = json.decode(fixtureData);

      final article = Map<String, dynamic>.from(sampleResponse);
      final tArticleModel = ArticleModel.fromJson(article);
      const articleId = "1";
      test(
        "should perform a put request on a URL",
        () async {
          when(mockClient.put(any,
                  headers: anyNamed('headers'), body: anyNamed('body')))
              .thenAnswer((_) async => http.Response(fixtureData, 200));

          final response = await remoteDataSourceImpl.updateArticle(
              articleId, tArticleModel);
          expect(response, equals(tArticleModel));
          final jsonBody = json.encode(tArticleModel.toJson());
          verify(
            mockClient.put(
                Uri.parse(
                    'https://66201f593bf790e070af11c1.mockapi.io/article/article/updateArticle/1'),
                headers: {'Content-Type': 'application/json'},
                body: jsonBody),
          );
        },
      );
      test(
        "should return the updated ArticleModel when the response code is 200 (success)",
        () async {
          when(mockClient.put(any,
                  headers: anyNamed('headers'), body: anyNamed('body')))
              .thenAnswer((_) async => http.Response(fixtureData, 200));

          final result = await remoteDataSourceImpl.updateArticle(
              articleId, tArticleModel);
          expect(result, equals(tArticleModel));
        },
      );
      test(
        'should throw a ServerException when the response code is not 404 or other',
        () async {
          when(mockClient.put(any,
                  headers: anyNamed('headers'), body: anyNamed('body')))
              .thenAnswer(
                  (_) async => http.Response('Something went wrong', 404));

          final call = remoteDataSourceImpl.updateArticle;
          expect(() => call(articleId, tArticleModel),
              throwsA(const TypeMatcher<ServerException>()));
        },
      );
    },
  );

  group(
    "postArticle",
    () {
      final fixtureData = fixture('article.json');
      final sampleResponse = json.decode(fixtureData);

      final article = Map<String, dynamic>.from(sampleResponse);
      final tArticleModel = ArticleModel.fromJson(article);
      const articleId = "1";
      test(
        "should perform a post request on a URL",
        () async {
          when(mockClient.post(any,
                  headers: anyNamed('headers'), body: anyNamed('body')))
              .thenAnswer((_) async => http.Response(fixtureData, 200));

          final response =
              await remoteDataSourceImpl.postArticle(tArticleModel);

          expect(response, equals(tArticleModel));
          final jsonBody = json.encode(tArticleModel.toJson());
          verify(
            mockClient.post(
              Uri.parse(
                  'https://66201f593bf790e070af11c1.mockapi.io/article/article'),
              headers: {'Content-Type': 'application/json'},
              body: jsonBody,
            ),
          );
        },
      );
      test(
        "should return the updated ArticleModel when the response code is 200 (success)",
        () async {
          when(mockClient.post(any,
                  headers: anyNamed('headers'), body: anyNamed('body')))
              .thenAnswer((_) async => http.Response(fixtureData, 200));

          final result = await remoteDataSourceImpl.postArticle(tArticleModel);

          expect(result, equals(tArticleModel));
        },
      );
      test(
        'should throw a ServerException when the response code is not 404 or other',
        () async {
          when(mockClient.post(any,
                  headers: anyNamed('headers'), body: anyNamed('body')))
              .thenAnswer(
                  (_) async => http.Response('Something went wrong', 404));

          final call = remoteDataSourceImpl.postArticle;
          expect(() => call(tArticleModel),
              throwsA(const TypeMatcher<ServerException>()));
        },
      );
    },
  );
}
