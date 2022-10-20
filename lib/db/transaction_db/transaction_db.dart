import 'package:budget_tracker/core/constants.dart';
import 'package:budget_tracker/models/transaction/transaction_model.dart';
import 'package:hive_flutter/adapters.dart';

class TransactionDb {
  Future<List<TransactionModel>> getTransactions() async {
    final box = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    final datas = box.values.toList();

    return datas;
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    final box = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    box.put(transaction.id, transaction);
  }
}
