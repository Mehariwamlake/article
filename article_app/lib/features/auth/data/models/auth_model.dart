import 'dart:convert';

import 'package:article_app/features/auth/domain/entites/auth.dart';

class AuthenticationModel extends AuthenticationEntites {
  AuthenticationModel({
    required String password,
    required String userName,
  }) : super(password: password, userName: userName);

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      password: json['password'],
      userName: json['userName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'userName': userName,
    };
  }
}
