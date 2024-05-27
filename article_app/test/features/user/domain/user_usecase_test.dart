import 'package:article_app/features/user/domain/entities/user.dart';
import 'package:article_app/features/user/domain/usecases/get_user.dart';
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

  const userDetail = User(
      id: '123',
      bio: 'bio',
      createdAt: 'haha',
      email: "email",
      expertise: 'expertes',
      fullName: 'mehari',
      image: 'kjal;sdj',
      imageCloudinaryPublicId: 'image',
      articles: []);

  test('should get current user detail from the repository', () async {
    // arrange
    when(mockUserRepository.getUser())
        .thenAnswer((_) async => const Right(userDetail));

    // act
    final result = await getCurrentWeatherUseCase.getUserData();

    // assert
    expect(result, const Right(userDetail));
  });
}
