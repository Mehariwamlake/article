import 'dart:html';
import 'package:article_app/features/user/data/datasources/user_remote_data_source.dart';
import 'package:article_app/features/user/domain/repositories/user_repository.dart';
import 'package:article_app/features/user/domain/usecases/get_user.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

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
