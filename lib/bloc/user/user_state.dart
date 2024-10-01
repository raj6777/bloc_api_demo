part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadig extends UserState {}

class UserLoaded extends UserState {
  final UserModel users;

  UserLoaded(this.users);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
