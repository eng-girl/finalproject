import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart'; // Import Iconsax
import '../../../bloc/cubit/auth_cubit.dart';
import '../../../data/models/store_model.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_cubit.dart';

class ProfilePage extends StatelessWidget {
  final Store store;

  ProfilePage({required this.store});

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthCubit>(context).currentUser; // Get current user
    final themeCubit = context.read<ThemeCubit>(); // Access the ThemeCubit

    return Directionality(
      textDirection: TextDirection.rtl, // RTL layout
      child: Scaffold(
        appBar: AppBar(
          title: Text("الاعدادات"), // Display store name
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 50.0,
                backgroundImage: NetworkImage(
                  store.image, // Display store image
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                store.name, // Display store name
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.white
                    : AppColors.black,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                user?.email ?? 'User Email', // Display user's email
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16.0),

              // Dark Mode Toggle ListTile
              ListTile(
                leading: Icon(Iconsax.activity, size: 24), // Iconsax icon for dark mode
                title: Text('الوضع المظلم'), // Dark Mode
                trailing: Switch(
                  value: themeCubit.state == ThemeMode.dark, // Check if dark mode is active
                  onChanged: (value) {
                    themeCubit.toggleTheme(); // Toggle theme
                  },
                  activeColor: AppColors.white,
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: Colors.black12,
                  inactiveThumbColor: AppColors.lightGrey,
                ),
              ),

              ListTile(
                leading: Icon(Iconsax.settings, size: 24), // Iconsax icon for settings
                title: Text('تعديل الحساب'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to the Setting screen
                },
              ),
              ListTile(
                leading: Icon(Iconsax.activity, size: 24), // Iconsax icon for friends
                title: Text('عنواني'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to the Friend screen
                },
              ),
              ListTile(
                leading: Icon(Iconsax.user_add, size: 24), // Iconsax icon for new group
                title: Text('منتجاتي'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to the New Group screen
                },
              ),
              ListTile(
                leading: Icon(Iconsax.support, size: 24), // Iconsax icon for support
                title: Text('طلباتي'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to the Support screen
                },
              ),
              ListTile(
                leading: Icon(Iconsax.share, size: 24), // Iconsax icon for sharing
                title: Text('أرباحي'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Implement the share functionality
                },
              ),
              ListTile(
                leading: Icon(Iconsax.logout, size: 24,color: Colors.red,), // Iconsax icon for about us
                title: Text('تسجيل الخروج'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to the About us screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}