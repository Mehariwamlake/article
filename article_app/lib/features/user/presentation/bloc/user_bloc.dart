import 'dart:async';

import 'package:article_app/core/errors/failures.dart';
import 'package:article_app/features/user/domain/entites/user_data.dart';
import 'package:article_app/features/user/domain/user_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String NETWORK_FAILURE_MESSAGE = 'Network Failure';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserData getUser;

  UserBloc({
    required this.getUser,
  }) : super(UserInitial()) {
    on<GetUserEvent>(_onGetUserData);
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

  FutureOr<void> _onGetUserData(
      GetUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingState());

    final userOrError = getUser;

    userOrError.fold(
      (failure) => emit(
        ErrorState(
          message: _mapFailureToMessage(failure),
        ),
      ),
      (user) => emit(
        LoadedUserState(userData: user),
      ),
    );
  }
}
