import 'package:budget_tracker/logic/add_transaction/add_transaction_cubit.dart';
import 'package:budget_tracker/logic/category/category screen/category_cubit.dart';
import 'package:budget_tracker/logic/category/category%20selector/cubit/category_selector_cubit.dart';
import 'package:budget_tracker/logic/home/cubit/recent_transactions_cubit.dart';
import 'package:budget_tracker/logic/theme/theme_cubit.dart';
import 'package:budget_tracker/models/category/category_model.dart';
import 'package:budget_tracker/models/transaction/transaction_model.dart';
import 'package:budget_tracker/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(CategoryTypeAdapter());
  Hive.registerAdapter(TransactionModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => ThemeCubit(),
          ),
          BlocProvider(
            create: (ctx) => CategoryCubit(),
          ),
          BlocProvider(
            create: (ctx) => CategorySelectorCubit(),
          ),
          BlocProvider(create: (ctx) => RecentTransactionsCubit()),
            BlocProvider(create: (ctx) => AddTransactionCubit()),
         
        ],
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
    home: const HomeScreen(),
  );
}
