abstract class LoginState {}

class UserInitial extends LoginState {}

class UserLoadig extends LoginState {}

class LoginUser extends LoginState {}

class UserError extends LoginState {
  final String message;

  UserError(this.message);
}
