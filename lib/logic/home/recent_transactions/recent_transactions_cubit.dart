// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:budget_tracker/db/transaction_db/transaction_db.dart';
import 'package:budget_tracker/models/transaction/transaction_model.dart';
import 'package:meta/meta.dart';

part 'recent_transactions_state.dart';

class RecentTransactionsCubit extends Cubit<RecentTransactionsState> {
  final TransactionDb transactionDb = TransactionDb();
  RecentTransactionsCubit() : super(RecentTransactionsLoadingState());

  void fetchAllRecentTransactions() async {
    try {
      final recentTransactions = await transactionDb.getTransactions();
      if (recentTransactions.isEmpty) {
        emit(RecentTransactionsEmptyState());
      } else {
        emit(RecentTransactionsLoadedState(recentTransactions));
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
