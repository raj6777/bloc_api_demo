import 'package:api_calling_bloc_mvvm_demo/model/NewsModel.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadig extends NewsState {}

class NewsLoaded extends NewsState {
  final NewsModel newsData;

  NewsLoaded(this.newsData);
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}
