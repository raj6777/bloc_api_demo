part of 'api_bloc.dart';

abstract class ApiState {}

class UserInitial extends ApiState {}

class UserLoadig extends ApiState {}

class UserLoaded extends ApiState {
  final UserModel users;

  UserLoaded(this.users);
}

class NewsLoaded extends ApiState {
  final NewsModel newsData;

  NewsLoaded(this.newsData);
}

class UserError extends ApiState {
  final String message;

  UserError(this.message);
}
