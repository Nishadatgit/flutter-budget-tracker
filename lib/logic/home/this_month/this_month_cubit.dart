// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:budget_tracker/db/reports_db/reports_db.dart';
import 'package:meta/meta.dart';

part 'this_month_state.dart';

class ThisMonthCubit extends Cubit<ThisMonthState> {
  ThisMonthCubit() : super(ThisMonthLoading());

  void getThisMonthData() async {
    final data = await ReportsDb().getThisMonthData();
    emit(ThisMonthLoaded(data));
  }
}
