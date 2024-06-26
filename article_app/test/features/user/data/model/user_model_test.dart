import 'dart:convert';

import 'package:article_app/features/user/data/models/user_model.dart';
import 'package:article_app/features/user/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helper/json_reader.dart';

void main() {
  const testUserModel = UserModel(
    id: 'id',
    fullName: 'fullName',
    email: 'email',
    expertise: 'expertise',
    bio: 'bio',
    createdAt: 'createdAt',
    image: 'image',
    imageCloudinaryPublicId: 'imageCloudinaryPublicId',
    articles: []
  );

  test('should be subclass of user entity', () async {
    expect(testUserModel, isA<User>());
  });

  test('should return a valid model from json', () async {
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('features/helper/user_dummy.json'),
    );
    final result = UserModel.fromJson(jsonMap);
    expect(result, equals(testUserModel));
  });
}
