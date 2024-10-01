import 'package:api_calling_bloc_mvvm_demo/presentation/profile_screen.dart';
import 'package:api_calling_bloc_mvvm_demo/presentation/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bottom_navigation/bottom_navigation_bloc.dart';
import '../bloc/bottom_navigation/bottom_navigation_state.dart';
import 'bottom_navigation.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final Map<BottomNavItem, Widget> screens = {
    BottomNavItem.home: const UserScreen(),
    BottomNavItem.search: Container(),
    BottomNavItem.profile: ProfileScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          return screens[state.selectedItem]!;
        },
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
