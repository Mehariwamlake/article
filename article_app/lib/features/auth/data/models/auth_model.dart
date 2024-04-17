import 'dart:convert';

import 'package:article_app/features/auth/domain/entites/auth.dart';

class AuthenticationModel extends Authentication {
  String id;
  String userName;
  String password;
  AuthenticationModel({
    required this.id,
    required this.password,
    required this.userName,
  }) : super(password: '123', userName: 'USER');

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      id: json['id'],
      password: json['password'],
      userName: json['userName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'userName': userName,
    };
  }
}
