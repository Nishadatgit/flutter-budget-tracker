import 'package:budget_tracker/models/category/category_model.dart';
import 'package:budget_tracker/models/transaction/transaction_model.dart';
import 'package:budget_tracker/screens/home/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/core/extensions.dart';

class ViewReport extends StatelessWidget {
  const ViewReport({super.key, required this.name, required this.transactions});
  final String name;
  final List<TransactionModel> transactions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name.toTitleCase(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            )),
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Text("No Transactions yet"),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                final transaction = transactions[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TransactionTile(
                      tileColor: transaction.category.categoryType ==
                              CategoryType.expense
                          ? Colors.red
                          : Colors.green,
                      category: transaction.category.categoryType.name,
                      title: transaction.purpose,
                      amount: transaction.amount,
                      date: transaction.date),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
