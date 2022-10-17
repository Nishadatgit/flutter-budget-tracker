// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:budget_tracker/themes/dark_theme.dart';
import 'package:budget_tracker/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeCubit extends Cubit<ThemeData> {
  static final brightness = SchedulerBinding.instance.window.platformBrightness;
  ThemeCubit() : super(brightness == Brightness.dark ? darkTheme : lightTheme);

  void switchTheme() =>
      state == lightTheme ? emit(darkTheme) : emit(lightTheme);
}
