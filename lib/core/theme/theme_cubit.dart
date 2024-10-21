import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

    void toggleTheme() {
      emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light); // Toggle between light and dark

    }
}

