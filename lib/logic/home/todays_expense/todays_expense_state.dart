part of 'todays_expense_cubit.dart';

@immutable
abstract class TodaysExpenseState {}

class TodaysExpenseInitial extends TodaysExpenseState {}

class TodaysExpenseLoaded extends TodaysExpenseState {
  final double amount;

  TodaysExpenseLoaded(this.amount);
}
