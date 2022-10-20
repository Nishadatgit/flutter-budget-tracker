part of 'recent_transactions_cubit.dart';

@immutable
abstract class RecentTransactionsState {}

class RecentTransactionsLoadingState extends RecentTransactionsState {}

class RecentTransactionsLoadedState extends RecentTransactionsState {
  final List<TransactionModel> transactions;

  RecentTransactionsLoadedState(this.transactions);
}

class RecentTransactionsEmptyState extends RecentTransactionsState {}

class ErrorState extends RecentTransactionsState {
  final String message;

  ErrorState(this.message);
}
