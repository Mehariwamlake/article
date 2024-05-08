import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

import 'package:article_app/features/user/data/data_source/user_remote.dart';
import 'package:article_app/features/user/domain/repository/user_repository.dart';
import 'package:article_app/features/user/domain/user_usecase.dart';

@GenerateMocks(
  [
    UserRepository,
    UserRemoteDataSource,
    GetUserData,
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
