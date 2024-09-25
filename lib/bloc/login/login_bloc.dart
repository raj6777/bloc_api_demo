import 'package:api_calling_bloc_mvvm_demo/bloc/login/login_event.dart';
import 'package:api_calling_bloc_mvvm_demo/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(UserInitial()) {
    on<LoginEventDetail>((event, emit) async {
      emit(UserLoadig()); // Correct the typo
      try {
        if (event.email == "" && event.password == "") {
          emit(UserInitial());
        } else {
          final success =
              await userRepository.login(event.email, event.password);
          if (success) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLogin', true);
            emit(LoginUser());
          } else {
            // Emit a failure state if login is unsuccessful
            emit(UserError("Login failed: Invalid email or password"));
          }
        }
      } catch (e) {
        emit(UserError("Failed to fetch users: $e"));
      }
    });
  }
}
