// ignore_for_file: prefer_for_elements_to_map_fromiterable

import 'package:budget_tracker/core/constants.dart';
import 'package:budget_tracker/models/category/category_model.dart';
import 'package:budget_tracker/models/transaction/transaction_model.dart';
import 'package:hive_flutter/adapters.dart';

class ReportsDb {
  Future<Map<String, List<TransactionModel>>>
      getTransactionsOfSpecificCategory() async {
    final transactionBox =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    final categoryBox = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    final List<String> categories =
        categoryBox.values.map((e) => e.name).toList();
    // ignore: prefer_for_elements_to_map_fromiterable
    Map<String, List<TransactionModel>> data = Map.fromIterable(
      categories,
      key: (element) => element,
      value: (element) => [],
    );
    for (String category in categories) {
      for (var item in transactionBox.values.toList()) {
        if (item.category.name == category) {
          data[category]!.add(item);
        }
      }
    }

    return data;
  }

  Future<Map<String, double>> getTotalData() async {
    double totalIncome = 0;
    double totalExpense = 0;

    final box = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    await Future.forEach(box.values.toList(), (item) {
      if (item.category.categoryType == CategoryType.expense) {
        totalExpense = totalExpense + item.amount;
      } else {
        totalIncome = totalIncome + item.amount;
      }
    });
    final Map<String, double> data = {
      "income": totalIncome,
      "expense": totalExpense
    };
    return data;
  }

  Future<Map<String, dynamic>> getThisMonthData() async {
    double totalncomeOfTheMonth = 0;
    double totalExpenseOfTheMoth = 0;
    List<TransactionModel> incomesOfThisMonth = [];
    List<TransactionModel> expensesOfThisMonth = [];
    final box = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    final transactions = box.values.toList();

    await Future.forEach(transactions, (transaction) {
      if (transaction.date.month == DateTime.now().month) {
        if (transaction.category.categoryType == CategoryType.income) {
          incomesOfThisMonth.add(transaction);
        } else {
          expensesOfThisMonth.add(transaction);
        }
      }
    });
    for (var incomeTransaction in incomesOfThisMonth) {
      totalncomeOfTheMonth = totalncomeOfTheMonth + incomeTransaction.amount;
    }
    for (var expenseTransaction in expensesOfThisMonth) {
      totalExpenseOfTheMoth = totalExpenseOfTheMoth + expenseTransaction.amount;
    }

    Map<String, dynamic> data = {
      "income_transactions": incomesOfThisMonth,
      "expense_transactions": expensesOfThisMonth,
      "total_income": totalncomeOfTheMonth,
      "total_expense": totalExpenseOfTheMoth
    };
    return data;
  }

  // Future<void> getTotalIncomeCategoryWise()async{

  //   final box = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
  //    final categoryBox = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  //   final List<String> categories =
  //       categoryBox.values.map((e) => e.name).toList();
  //   Map<String, List<TransactionModel>> data = Map.fromIterable(
  //     categories,
  //     key: (element) => element.,
  //     value: (element) => [],
  //   );

  // }

  Future<double> getTodaysExpense() async {
    double expense = 0;
    final box = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    final transactions = box.values.toList();
    await Future.forEach(transactions, (transaction) {
      if (transaction.date.day == DateTime.now().day) {
        expense = expense + transaction.amount;
      }
    });
    return expense;
  }
}
