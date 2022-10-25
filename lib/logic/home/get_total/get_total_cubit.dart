// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:budget_tracker/db/reports_db/reports_db.dart';
import 'package:meta/meta.dart';

part 'get_total_state.dart';

class GetTotalCubit extends Cubit<GetTotalState> {
  GetTotalCubit() : super(GetTotalLoading());

  void getTotalData() async {
   final data= await ReportsDb().getTotalData();
    emit(GetTotalLoaded(data));
  }
}
