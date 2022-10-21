part of 'reports_cubit.dart';

@immutable
abstract class ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsLoaded extends ReportsState {
  final Map<String, List<TransactionModel>> data;

  ReportsLoaded(this.data);
}

class NoReportsState extends ReportsState {}
