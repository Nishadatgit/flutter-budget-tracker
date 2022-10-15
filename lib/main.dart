import 'package:budget_tracker/screens/home/home_screen.dart';
import 'package:budget_tracker/themes/dark_theme.dart';
import 'package:budget_tracker/themes/light_theme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: darkTheme,
      home: const HomeScreen(),
    );
  }
}

//6953f7
//cdf4f7