import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../bloc/cubit/bottom_nav_bar_cubit.dart';
import '../../bloc/state/bottom_nav_bar_state.dart';
import '../cutomer_side/navigation_screens/profile_screen.dart';
import 'navigation_screens/home_screen.dart';
import 'navigation_screens/product_screen.dart';
import 'navigation_screens/order_screen.dart';
import 'navigation_screens/order_screen.dart';

class storemainlayout extends StatefulWidget {
  const storemainlayout({super.key});

  @override
  State<storemainlayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<storemainlayout> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
          builder: (context, state) {
            if (state.navbarItem == NavbarItem.home) {
              // الرئيسىة
              return StorInfo();
            } else if (state.navbarItem == NavbarItem.stores) {
              // المنتجات
              return ProductInfo();
            } else if (state.navbarItem == NavbarItem.profile) {
              // الطلبات
              return OrderInfo();
            }
            return Container();
          },
        ),
        bottomNavigationBar: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.index,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              iconSize: screenWidth * 0.07,
              selectedLabelStyle: TextStyle(
                fontSize: screenWidth * 0.041,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: screenWidth * 0.041,
              ),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: 'الرئيسية',
                  icon: Icon(Iconsax.shop),
                ),
                BottomNavigationBarItem(
                  label: 'المنتجات',
                  icon: Icon(Iconsax.box),
                ),
                BottomNavigationBarItem(
                  label: 'الطلبات',
                  icon: Icon(Iconsax.receipt_text),
                ),
              ],
              onTap: (index) {
                if (index == 0) {
                  BlocProvider.of<BottomNavBarCubit>(context)
                      .getNavBarItem(NavbarItem.home);
                } else if (index == 1) {
                  BlocProvider.of<BottomNavBarCubit>(context)
                      .getNavBarItem(NavbarItem.stores);
                } else if (index == 2) {
                  BlocProvider.of<BottomNavBarCubit>(context)
                      .getNavBarItem(NavbarItem.profile);
                }
              },
            );
          },
        ),
      ),
    );
  }
}