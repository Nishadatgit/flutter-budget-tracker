part of 'add_transaction_cubit.dart';

@immutable
abstract class AddTransactionState {}
class AddTransactionInitial extends AddTransactionState {}
class AddingTransaction extends AddTransactionState {}
class AddedTransaction extends AddTransactionState{}
