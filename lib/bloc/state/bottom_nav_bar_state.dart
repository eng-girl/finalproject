
import 'package:equatable/equatable.dart';

enum NavbarItem { home, stores, profile }

 class BottomNavBarState extends Equatable {

   final NavbarItem navbarItem;
   final int index;

  const BottomNavBarState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}
