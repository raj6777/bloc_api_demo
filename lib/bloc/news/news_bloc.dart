import 'package:api_calling_bloc_mvvm_demo/repository/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoadig());
      try {
        final news = await newsRepository.fetchTopHeadlines();
        emit(NewsLoaded(news));
      } catch (e) {
        emit(NewsError("Failed to fetch users: $e")); //
      }
    });
  }
}
