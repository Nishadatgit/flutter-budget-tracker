// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:budget_tracker/db/reports_db/reports_db.dart';
import 'package:budget_tracker/models/transaction/transaction_model.dart';
import 'package:meta/meta.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsLoading());

  void getData() async {
    emit(ReportsLoading());
    final data = await ReportsDb().getTransactionsOfSpecificCategory();
    if (data.values.toList().isEmpty) {
      
      emit(NoReportsState());
    }
    emit(ReportsLoaded(data));
  }
}
