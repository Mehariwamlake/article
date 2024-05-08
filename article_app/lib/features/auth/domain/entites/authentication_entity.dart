import 'package:equatable/equatable.dart';

import 'authenticated_user_info.dart';

class AuthenticationEntity extends Equatable {
  final String token;

  const AuthenticationEntity(
      {required this.token});

  @override
  List<Object?> get props => [token];
}
