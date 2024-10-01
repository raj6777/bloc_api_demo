import 'package:equatable/equatable.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateTo extends BottomNavigationEvent {
  final int index;

  const NavigateTo(this.index);

  @override
  List<Object> get props => [index];
}
