import 'package:bloc/bloc.dart';
import 'package:budget_tracker/db/transaction_db/transaction_db.dart';
import 'package:budget_tracker/models/transaction/transaction_model.dart';
import 'package:meta/meta.dart';

part 'add_transaction_state.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {
  AddTransactionCubit() : super(AddTransactionInitial());

  Future<void> addTransaction(TransactionModel transactionModel) async {
    emit(AddingTransaction());
    await TransactionDb().addTransaction(transactionModel);
    emit(AddedTransaction());
  }
}
