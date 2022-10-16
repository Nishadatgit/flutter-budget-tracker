import 'package:bloc/bloc.dart';
import 'package:budget_tracker/themes/dark_theme.dart';
import 'package:budget_tracker/themes/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeData> {
  
  
  ThemeCubit() : super(lightTheme);

  void switchTheme() =>
      state == lightTheme ? emit(darkTheme) : emit(lightTheme);
}
