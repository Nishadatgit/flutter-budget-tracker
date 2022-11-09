import 'package:bloc/bloc.dart';
import 'package:budget_tracker/db/reports_db/reports_db.dart';
import 'package:meta/meta.dart';

part 'todays_expense_state.dart';

class TodaysExpenseCubit extends Cubit<TodaysExpenseState> {
  TodaysExpenseCubit() : super(TodaysExpenseInitial());
  ReportsDb reportsDb = ReportsDb();

  void fetchTodaysExpense() async {
    emit(TodaysExpenseInitial());
    final expense = await reportsDb.getTodaysExpense();
    emit(TodaysExpenseLoaded(expense));
  }
}
