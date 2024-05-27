import 'dart:convert';

import 'package:article_app/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/entities/user_data.dart';
import '../models/user_data_model.dart';
import 'user_remote_data_source.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;


  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserDataModel> getUserData(String token) async {
    try {
      if (token == null) {
        throw ArgumentError('Token cannot be null');
      }

      final http.Response response = await client.get(
        Uri.parse('https://mock.apidog.com/m1/524680-485106-default/user'),
        headers: {
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return UserDataModel.fromJson(decoded);
      } else {
        throw ServerException1(
            "Error ${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (e) {
      // Catch any other exceptions and throw them as ServerException
      print("Exception during API call: $e");
      throw ServerException1("Error: $e");
    }
  }

  @override
  Future<UserData> updateUserPhoto(String token, String imagePath) async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    final request = http.MultipartRequest(
        'PUT', Uri.parse('${apiBaseUrl}user/update/image'));
    request.headers.addAll(headers);

    print(Uri.parse('${apiBaseUrl}user/update/image'));
    // final imageBytes = await File(imagePath).readAsBytes();

    request.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        imagePath,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();

        return UserDataModel.fromJson(json.decode(responseString)['data']);
      } else {
        throw const ServerException();
      }
    } catch (e) {
      throw const ServerException();
    }
  }
}
