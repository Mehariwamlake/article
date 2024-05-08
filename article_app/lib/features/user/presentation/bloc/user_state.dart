part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class LoadingState extends UserState {}

class LoadedUserState extends UserState {
  final UserEntity userData;

  const LoadedUserState({required this.userData});
}

class UserProfileUpdatedState extends UserState {}

class ErrorState extends UserState {
  final String message;

  const ErrorState({required this.message});
}
