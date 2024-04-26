import 'dart:convert';

import 'package:article_app/core/errors/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../models/authenticated_user_info_model.dart';
import '../models/authentication_model.dart';
import '../models/login_model.dart';
import '../models/sign_up_model.dart';
import 'remote_data_source.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final http.Client client;
  AuthRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<AuthenticationModel> login(LoginRequestModel loginRequestModel) async {
    final http.Response response = await client.post(
        Uri.parse('https://reqres.in/api/login'),
        body: jsonEncode(loginRequestModel.toJson()),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (kDebugMode) {
        print('responseBody: $responseBody');
      }
      return AuthenticationModel.fromJson(responseBody);
    } else if (response.statusCode == 400) {
      throw const LoginException(message: 'Invalid Credentials');
    } else {
      throw ServerException(message: 'Server Error');
    }
  }

  @override
  Future<AuthenticatedUserInfoModel> signUp(
      SignUpRequestModel signUpRequestModel) async {
    final http.Response response = await client.post(
        Uri.parse('${apiBaseUrl}user'),
        body: jsonEncode(signUpRequestModel.toJson()),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return AuthenticatedUserInfoModel.fromJson(responseBody['data']);
    } else if (response.statusCode == 409 || response.statusCode == 400) {
      throw const SignUpException(message: 'Invalid information');
    } else {
      throw ServerException(message: 'Server Error');
    }
  }

  @override
  Future<void> logout(String token) async {
    final http.Response response = await client.post(
        Uri.parse('${apiBaseUrl}user/logout'),
        body: jsonEncode({'token': token}),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      throw const LogoutException(
        message: 'Unauthorized',
      );
    } else {
      throw ServerException();
    }
  }
}
