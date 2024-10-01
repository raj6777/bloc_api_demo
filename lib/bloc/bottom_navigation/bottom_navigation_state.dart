import 'package:equatable/equatable.dart';

enum BottomNavItem { home, search, profile }

class BottomNavigationState extends Equatable {
  final BottomNavItem selectedItem;

  const BottomNavigationState({required this.selectedItem});

  @override
  List<Object> get props => [selectedItem];
}
