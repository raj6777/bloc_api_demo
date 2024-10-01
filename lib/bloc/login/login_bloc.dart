import 'package:api_calling_bloc_mvvm_demo/bloc/login/login_event.dart';
import 'package:api_calling_bloc_mvvm_demo/bloc/login/login_state.dart';
import 'package:api_calling_bloc_mvvm_demo/repository/login_repository.dart';
import 'package:api_calling_bloc_mvvm_demo/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../model/UserModel.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  final UserRepository userRepository;
  late final Store newStore;

  LoginBloc(
      {required this.loginRepository,
      required this.userRepository,
      required this.newStore})
      : super(UserInitial()) {
    on<LoginEventDetail>((event, emit) async {
      emit(UserLoadig()); // Correct the typo

      try {
        if (event.email.isEmpty || event.password.isEmpty) {
          emit(UserInitial());
        } else {
          final success =
              await loginRepository.login(event.email, event.password);
          if (success) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLogin', true);

            // Fetch users after successful login
            final users = await userRepository.fetchUsers();
            final singleUser = users.data.firstWhere(
              (user) => user.email == event.email,
              orElse: () =>
                  throw Exception("User not found for the provided email."),
            );

            if (singleUser != null) {
              print(
                  "<---------------------------${singleUser.email}------------------------>");

              // Create the Datum instance for the specific user
              final datum = Datum(
                id: singleUser.id,
                email: singleUser.email,
                firstName: singleUser.firstName,
                lastName: singleUser.lastName,
                avatar: singleUser.avatar,
              );

              // Create a box for Datum using the initialized store
              final datumBox = newStore.box<Datum>();

              // Store the datum instance in ObjectBox
              datumBox.put(datum);

              // Call checkStoredData to print stored data
              checkStoredData(datumBox);

              emit(LoginUser());
            } else {
              emit(UserError("User not found for the provided email."));
            }
          } else {
            emit(UserError("Login failed: Invalid email or password"));
          }
        }
      } catch (e) {
        emit(UserError("Failed to fetch users: $e"));
      }
    });
  }

  void checkStoredData(Box<Datum> datumBox) {
    final allData = datumBox.getAll();

    // Check and print all stored Datum objects
    if (allData.isNotEmpty) {
      print("Stored Datum objects in ObjectBox:");
      for (var datum in allData) {
        print(
            "ID: ${datum.id}, Email: ${datum.email}, First Name: ${datum.firstName}, Last Name: ${datum.lastName}, Avatar: ${datum.avatar}");
      }
    } else {
      print("No Datum objects found in ObjectBox.");
    }
  }
}
