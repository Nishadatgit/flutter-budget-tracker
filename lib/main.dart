import 'package:budget_tracker/logic/cubit/theme_cubit.dart';
import 'package:budget_tracker/screens/home/home_screen.dart';
import 'package:budget_tracker/themes/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (contex) => ThemeCubit(),
        child: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, state) {
            return _buildWithTheme(context, state);
          },
        ));
  }
}

Widget _buildWithTheme(BuildContext context, state) {
  return MaterialApp(
    title: 'Budget Tracker',
    theme: state,
    themeAnimationCurve: Curves.easeInOut,
    themeAnimationDuration: const Duration(seconds: 1),
    home: const HomeScreen(),
  );
}



//6953f7
//cdf4f7