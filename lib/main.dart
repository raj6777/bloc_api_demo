import 'package:api_calling_bloc_mvvm_demo/bloc/login/login_bloc.dart';
import 'package:api_calling_bloc_mvvm_demo/bloc/news/news_bloc.dart';
import 'package:api_calling_bloc_mvvm_demo/bloc/profile/profile_event.dart';
import 'package:api_calling_bloc_mvvm_demo/presentation/HomeScreen.dart';
import 'package:api_calling_bloc_mvvm_demo/presentation/login.dart';
import 'package:api_calling_bloc_mvvm_demo/userimpl/LoginRepositoryImpl.dart';
import 'package:api_calling_bloc_mvvm_demo/userimpl/NewsRepositoryImpl.dart';
import 'package:api_calling_bloc_mvvm_demo/userimpl/UserRepositoryImpl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox/objectbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'bloc/news/news_event.dart';
import 'bloc/profile/profile_bloc.dart';
import 'bloc/user/ObjectBox.dart';
import 'objectbox.g.dart';

late ObjectBox objectbox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check login state
  final prefs = await SharedPreferences.getInstance();
  bool isLogin =
      prefs.getBool('isLogin') ?? false; // Default to false if not found
  objectbox = await ObjectBox.create();

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
          create: (context) => LoginBloc(loginRepository: LoginRepositoryImpl(),userRepository: UserRepositoryImpl(),newStore: objectbox.store),
        ),
        BlocProvider(
          create: (context) =>
              NewsBloc(newsRepository: NewsRepositoryImpl())..add(FetchNews()),
        ),
        BlocProvider(
          create: (context) =>
          BottomNavigationBloc(),
        ),
        BlocProvider(create:(context) => ProfileBloc()..add(FetchProfileEvent()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isLogin ?  Homescreen() : LoginPage(),
      ),
    );
  }
}
