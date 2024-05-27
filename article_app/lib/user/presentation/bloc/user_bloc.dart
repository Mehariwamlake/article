import 'dart:async';

import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/core/usecases/usecase.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_data.dart';
import '../../domain/usecases/user_usecases/get_user_data_usecase.dart';
import '../../domain/usecases/user_usecases/update_user_photo_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

final String token = 'token';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserData getUser;
  final UpdateUserPhoto updateUserPhoto;

  UserBloc({
    required this.getUser,
    required this.updateUserPhoto,
  }) : super(UserInitial()) {
    on<GetUserEvent>(_onGetUserData);
    on<UpdateUserPhotoEvent>(_onUpdateUserPhoto);
  }

  FutureOr<void> _onGetUserData(
      GetUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingState());

    final userOrError = await getUser(GetUserDataParams(token: event.token));

    userOrError.fold(
      (failure) => emit(ErrorState(failure.toString())),
      (user) => emit(
        LoadedUserState(userData: user),
      ),
    );
  }

  FutureOr<void> _onUpdateUserPhoto(
      UpdateUserPhotoEvent event, Emitter<UserState> emit) async {
    emit(LoadingState());
    final userOrError = await updateUserPhoto(
      UpdateUserPhotoParams(token: event.token, imagePath: event.imagePath),
    );

    userOrError.fold(
      (failure) => emit(ErrorState(failure.toString())),
      (user) => emit(
        UserProfileUpdatedState(),
      ),
    );
  }
}
