import 'package:api_calling_bloc_mvvm_demo/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:bloc/bloc.dart';

import 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc()
      : super(const BottomNavigationState(selectedItem: BottomNavItem.home)) {
    on<NavigateTo>((event, emit) {
      switch (event.index) {
        case 0:
          emit(const BottomNavigationState(selectedItem: BottomNavItem.home));
          break;
        case 1:
          emit(const BottomNavigationState(selectedItem: BottomNavItem.search));
          break;
        case 2:
          emit(
              const BottomNavigationState(selectedItem: BottomNavItem.profile));
          break;
      }
    });
  }
}
