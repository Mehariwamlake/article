import 'dart:convert';

import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/features/auth/data/data_source/auth_remote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../article/data/datasource/article_remote_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AuthRemoteDataSoureceImpl dataSoureceImpl;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSoureceImpl = AuthRemoteDataSoureceImpl(client: mockHttpClient);
  });

  group('signup', () {
    final newUser = Authentication(
      userName: 'eve.holt@reqres.in',
      password: 'pistol',
    );
    final newUserModel = AuthenticationModel(
      userName: 'testuser',
      password: 'testpassword',
      id: '1',
    );

    test(
      'should perform a POST request on the signup endpoint with the given authentication data',
      () async {
        // Arrange
        final expectedUri = Uri.parse('https://reqres.in/api/register');
        when(mockHttpClient.post(
          expectedUri,
          body: newUser,
          headers: {'Content-Type': 'application/json'},
        )).thenAnswer((_) async =>
            http.Response(json.encode(newUserModel.toJson()), 200));

        // Act
        await dataSoureceImpl.signup(newUser);

        // Assert
        verify(mockHttpClient.post(
          expectedUri,
          body: newUser,
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return an AuthenticationModel when the signup request is successful',
      () async {
        // arrange
        final expectedUri = Uri.parse('https://reqres.in/api/register');
        when(mockHttpClient.post(
          expectedUri,
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async =>
            http.Response(json.encode(newUserModel.toJson()), 200));

        // act
        final result = await dataSoureceImpl.signup(newUser);

        // assert
        expect(result, equals(newUserModel));
      },
    );

    test(
      'should throw a ServerException when the signup request is unsuccessful',
      () async {
        // arrange
        final expectedUri = Uri.parse('https://reqres.in/api/register');
        when(mockHttpClient.post(
          expectedUri,
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response('Error', 400));

        // act
        final call = dataSoureceImpl.signup(newUser);

        // assert
        expect(call, throwsA(isInstanceOf<ServerException>()));
      },
    );
  });
}
