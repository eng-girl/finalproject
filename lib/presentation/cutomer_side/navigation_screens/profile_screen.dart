import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/themeButton.dart';

class ProfileScreen extends StatelessWidget {
  final String? profileImageUrl;

  const ProfileScreen({Key? key, this.profileImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: screenWidth * 0.12, // You can adjust the size here
              backgroundImage:
                  profileImageUrl != null && profileImageUrl!.isNotEmpty
                      ? NetworkImage(profileImageUrl!) // Load image from URL
                      : null, // No child if image is available
              backgroundColor: Colors.grey, // Placeholder if no image
              child: profileImageUrl == null || profileImageUrl!.isEmpty
                  ? const Icon(Icons.person,
                      size: 50, color: Colors.white) // Default icon
                  : null, // Background color for placeholder
            ),
            ListTileForProfile(
                title: 'الوضع الليلي',
                leadingIcon: const ThemeSwitchButton(),
                trailing: const Icon(Icons.dark_mode),

            ),ListTileForProfile(
                title: 'تعديل الحساب',
                leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded ,),
                trailing: const Icon(Icons.account_circle_rounded),

            ),ListTileForProfile(
                title: 'عنواني' ,
                leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded ,),
                trailing: const Icon(Icons.location_on),

            ),ListTileForProfile(
                title: 'تسجيل خروج',
                leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded ,),
                trailing: const Icon(Icons.logout_rounded),

            ),
          ],
        ),
      ),
    );
  }
}

class ListTileForProfile extends StatelessWidget {
  String title;
  Widget leadingIcon;
  Widget trailing;

  ListTileForProfile(
      {required this.title,
      required this.leadingIcon,
      required this.trailing,
      super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        ListTile(
          title: Text(title , textDirection: TextDirection.rtl),
          leading: leadingIcon,
          trailing: trailing,
          contentPadding:  EdgeInsets.symmetric(horizontal:screenWidth * 0.075),
        ),
         Divider(thickness: 0.5,
          height: 0.2,
          indent: screenWidth * 0.1, // 10% of screen width for indent
          endIndent: screenWidth * 0.1, ),
      ],
    );
  }
}
