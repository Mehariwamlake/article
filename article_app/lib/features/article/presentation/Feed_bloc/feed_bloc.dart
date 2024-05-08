import 'package:article_app/core/usecases/usecase.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/domain/usecases/get_all_articles.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetAllArticles getAllArticles;

  FeedBloc({required this.getAllArticles}) : super(InitialFeedState()) {
    on<GetAllArticlesEvent>((event, emit) async {
      emit(LoadingFeedState());
      final allArticles = await getAllArticles(NoParams());
      allArticles.fold(
        (error) => emit(ErrorFeedState(message: error.toString())),
        (articles) => emit(LoadedFeedState(articles: articles)),
      );

    });
  }
}