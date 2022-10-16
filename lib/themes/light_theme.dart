import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        bodyMedium: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        bodySmall: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
    primaryColor: Colors.purple,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black));
