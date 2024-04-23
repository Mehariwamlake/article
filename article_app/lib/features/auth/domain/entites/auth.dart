import 'package:equatable/equatable.dart';

class Authentication extends Equatable {
  final String password;
  final String userName;

  Authentication({required this.password, required this.userName}) : super();

  @override
  List<Object?> get props => [userName, password];
}
