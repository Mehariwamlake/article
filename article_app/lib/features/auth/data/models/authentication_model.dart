import 'package:article_app/features/auth/domain/entites/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required String token}) : super(token: token);

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'],
    );
  }
}
