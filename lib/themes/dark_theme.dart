import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xff302d43),
  textTheme: const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
      bodyMedium: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      bodySmall: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff302d43),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  primaryColor: Colors.white,
);
