import 'package:equatable/equatable.dart';

class AuthenticationEntites extends Equatable {
  final String password;
  final String userName;

  AuthenticationEntites({required this.password, required this.userName}) : super();

  @override
  List<Object?> get props => [userName, password];
}
