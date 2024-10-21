import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../state/bottom_nav_bar_state.dart';


class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarState(NavbarItem.home, 0));
  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(const BottomNavBarState(NavbarItem.home, 0));
        break;
      case NavbarItem.stores:
        emit(const BottomNavBarState(NavbarItem.stores, 1));
        break;
      case NavbarItem.profile:
        emit(const BottomNavBarState(NavbarItem.profile, 2));
        break;
    }
  }
}
