import 'package:article_app/features/auth/domain/entites/authenticated_user_info.dart';
import 'package:article_app/features/auth/domain/entites/authentication_entity.dart';

import 'authenticated_user_info_model.dart';

class AuthenticationModel extends AuthenticationEntity {
  const AuthenticationModel({required String token}) : super(token: token);

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      token: json['token'],
    );
  }
}
