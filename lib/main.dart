import 'package:api_calling_bloc_mvvm_demo/bloc/api_bloc.dart';
import 'package:api_calling_bloc_mvvm_demo/bloc/api_event.dart';
import 'package:api_calling_bloc_mvvm_demo/bloc/login/login_bloc.dart';
import 'package:api_calling_bloc_mvvm_demo/presentation/login.dart';
import 'package:api_calling_bloc_mvvm_demo/presentation/user_screen.dart';
import 'package:api_calling_bloc_mvvm_demo/userimpl/UserRepositoryImpl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check login state
  final prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getBool('isLogin') ?? false; // Default to false if not found

  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;

  const MyApp({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(userRepository: UserRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) =>
          ApiBloc(userRepository: UserRepositoryImpl())..add(FetchNews()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isLogin ? const UserScreen() : LoginPage(),
      ),
    );
  }
}
