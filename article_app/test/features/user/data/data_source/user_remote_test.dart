import 'package:article_app/features/user/data/data_source/user_remote.dart';
import 'package:article_app/features/user/data/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helper/json_reader.dart';
import '../../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late UserRemoteDataSourceImpl userRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    userRemoteDataSourceImpl = UserRemoteDataSourceImpl(client: mockHttpClient);
  });
  group('get user data', () {
    test('shuld return user model when the response code is 200', () async {
      when(mockHttpClient.get(Uri.parse(
              'https://mock.apidog.com/m1/524680-485106-default/user')))
          .thenAnswer(
        (_) async =>
            http.Response(readJson('features/helper/user_dummy.json'), 200),
      );

      final result = userRemoteDataSourceImpl.getUserData;
      expect(result, isA<UserModel>());
    });
  });
}
