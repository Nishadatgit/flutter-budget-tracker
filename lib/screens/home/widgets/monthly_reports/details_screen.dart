import 'package:budget_tracker/models/transaction/transaction_model.dart';
import 'package:budget_tracker/screens/home/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

class ThisMonthDetilsScreen extends StatelessWidget {
  const ThisMonthDetilsScreen(
      {super.key, required this.title, required this.transactions});
  final String title;
  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            )),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TransactionTile(
                tileColor: title == "Income" ? Colors.green : Colors.red,
                category: transaction.category.name,
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
