import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/theme_cubit.dart';


class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Switch(
      value: isDarkMode,
      onChanged: (value) {
        context.read<ThemeCubit>().toggleTheme();
      },
      activeColor: AppColors.white,
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: Colors.black12,
      inactiveThumbColor: AppColors.lightGrey,
    );
  }
}