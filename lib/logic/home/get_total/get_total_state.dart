part of 'get_total_cubit.dart';

@immutable
abstract class GetTotalState {}

class GetTotalLoading extends GetTotalState {}

class GetTotalLoaded extends GetTotalState {
  final Map<String, double> totalAmounts;

  GetTotalLoaded(this.totalAmounts);
}

class GetTotalError extends GetTotalState {}
