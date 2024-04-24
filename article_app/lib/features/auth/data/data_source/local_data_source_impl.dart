import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exception.dart';
import 'local_data_source.dart';

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  AuthLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<void> cacheToken(String token) async {
    await sharedPreferences.setString(LocalStorageConstants.TOKEN, token);
  }

  @override
  Future<void> removeToken() async {
    await sharedPreferences.remove(LocalStorageConstants.TOKEN);
  }

  @override
  Future<String> getToken() {
    final token = sharedPreferences.getString(LocalStorageConstants.TOKEN);
    if (token != null) {
      return Future.value(token);
    } else {
      throw const CacheException(message: 'Token not found');
    }
  }

  @override
  Future<void> deleteLoggedInUser() async {
    sharedPreferences.remove(LocalStorageConstants.AUTHENTICATED_USER_INFO);
    sharedPreferences.remove(LocalStorageConstants.TOKEN);
  }

  @override
  Future<void> cacheLoggedInUser(userToCache) {
    // TODO: implement cacheLoggedInUser
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getLoggedInUser() {
    // TODO: implement getLoggedInUser
    throw UnimplementedError();
  }
}
