import 'package:article_app/features/user/domain/entites/user_data.dart';
import 'package:article_app/features/user/domain/user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetUserData getCurrentWeatherUseCase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    getCurrentWeatherUseCase = GetUserData(mockUserRepository);
  });

  const userDetail = UserEntity(
      id: '123',
      bio: 'bio',
      createdAt: 'haha',
      email: "email",
      expertise: 'expertes',
      fullName: 'mehari',
      image: 'kjal;sdj',
      imageCloudinaryPublicId: 'image');

  test('should get current user detail from the repository', () async {
    // arrange
    when(mockUserRepository.getUserData())
        .thenAnswer((_) async => const Right(userDetail));

    // act
    final result = await getCurrentWeatherUseCase.getUserData();

    // assert
    expect(result, const Right(userDetail));
  });
}
