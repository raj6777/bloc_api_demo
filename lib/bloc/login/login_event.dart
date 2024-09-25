abstract class LoginEvent {}

class LoginEventDetail extends LoginEvent {
  final String email;
  final String password;

  LoginEventDetail({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
