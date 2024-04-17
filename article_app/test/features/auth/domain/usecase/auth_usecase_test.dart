import 'package:article_app/features/auth/domain/entites/auth.dart';
import 'package:article_app/features/auth/domain/repository/auth_repository.dart';
import 'package:article_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_usecase_test.mocks.dart';

@GenerateMocks([AuthenticationRepository])
void main() {
  late LoginUseCase loginUseCase;
  late SignupUseCase signupUseCase;
  late MockAuthenticationRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    loginUseCase = LoginUseCase(mockRepository);
    signupUseCase = SignupUseCase(mockRepository);
  });
  test("description", () async {
    final user = Authentication(password: "password", userName: "userName");

    when(mockRepository.login(user)).thenAnswer((_) async => Right(user));

    final result = await loginUseCase(user);
    expect(result, Right(user));
    verify(mockRepository.login(user));
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return object from repo", () async {
    final newUser =
        Authentication(password: "newpassword", userName: "newuserName");

    when(mockRepository.signup(newUser))
        .thenAnswer((_) async => Right(newUser));

    final result = await signupUseCase(newUser);
    expect(result, Right(newUser));
    verify(mockRepository.signup(newUser));
    verifyNoMoreInteractions(mockRepository);
  });
}
