import 'dart:convert';

import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/features/auth/data/models/auth_model.dart';
import 'package:article_app/features/auth/domain/entites/auth.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<AuthenticationEntites> signup(AuthenticationModel newUser);
  Future<AuthenticationEntites> login(AuthenticationModel user);
}

class AuthRemoteDataSoureceImpl implements AuthRemoteDataSource {
  final http.Client client;
  String url = 'https://reqres.in/api';

  AuthRemoteDataSoureceImpl({required this.client, required Object sharedPreferences});

  @override
  Future<AuthenticationModel> signup(AuthenticationEntites newUser) async {
    final response = await client.post(
      Uri.parse('$url/register'),
      body: newUser,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return AuthenticationModel.fromJson(data);
    } else {
      throw ServerException('Failed to signup');
    }
  }

  @override
  Future<AuthenticationModel> login(
      AuthenticationModel authenticationModel) async {
    final response = await client.post(
      Uri.parse('$url/login'),
      body: jsonEncode(authenticationModel
          .toJson()), // Assuming `toJson()` method is implemented in the `AuthenticationModel` class
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return AuthenticationModel.fromJson(data);
    } else {
      throw ServerException(
          'Failed to login'); // Update the error message if desired
    }
  }
}
