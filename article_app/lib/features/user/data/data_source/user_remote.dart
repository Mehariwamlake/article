import 'dart:convert';

import 'package:article_app/core/errors/exceptions.dart';
import 'package:article_app/features/user/data/model/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserModel> getUserData();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getUserData() async {
    final response = await client.get(
      Uri.parse('https://mock.apidog.com/m1/524680-485106-default/user'),
    );

    if (response.statusCode == 200) {
      try {
        return UserModel.fromJson(json.decode(response.body));
      } catch (e) {
        throw const ServerException();
      }
    } else {
      throw const ServerException();
    }
  }
}
