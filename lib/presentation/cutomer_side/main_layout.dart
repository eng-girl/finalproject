
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubit/bottom_nav_bar_cubit.dart';
import '../../bloc/state/bottom_nav_bar_state.dart';
import 'navigation_screens/home_screen.dart';
import 'navigation_screens/profile_screen.dart';
import 'navigation_screens/stores_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
            builder: (context, state) {
              if (state.navbarItem == NavbarItem.home) {
                return HomeScreen();
              } else if (state.navbarItem == NavbarItem.stores) {
                return StoresScreen();
              } else if (state.navbarItem == NavbarItem.profile) {
                return ProfileScreen();
              }
              return Container();
            }),


        bottomNavigationBar: BlocBuilder<BottomNavBarCubit,BottomNavBarState>(
          builder: (context, state){
          return BottomNavigationBar(
            currentIndex: state.index,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            iconSize:  screenWidth * 0.07,
            selectedLabelStyle:  TextStyle(
              fontSize: screenWidth * 0.041,
            ),
            unselectedLabelStyle:  TextStyle(
              fontSize: screenWidth * 0.041,
            ),

            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: 'المتاجر',
                icon: Icon(
                  Icons.store_rounded,
                ),
              ),
              BottomNavigationBarItem(
                label: 'الرئيسية',
                icon: Icon(Icons.home_rounded),
              ),
              BottomNavigationBarItem(
                label: 'حسابي',
                icon: Icon(Icons.person_rounded),
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



          }
        )


      ),
    );
  }
}
