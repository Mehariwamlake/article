part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {}

class UpdateUserPhotoEvent extends UserEvent {
  final String token;
  final String imagePath;

  const UpdateUserPhotoEvent({required this.token, required this.imagePath});
}

class GetBookmarkedArticlesEvent extends UserEvent {
  const GetBookmarkedArticlesEvent();
}
