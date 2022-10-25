part of 'this_month_cubit.dart';

@immutable
abstract class ThisMonthState {}

class ThisMonthLoading extends ThisMonthState {}
class ThisMonthEmpty extends ThisMonthState {}

class ThisMonthLoaded extends ThisMonthState {
 final Map<String, dynamic> data;

  ThisMonthLoaded(this.data);
}
