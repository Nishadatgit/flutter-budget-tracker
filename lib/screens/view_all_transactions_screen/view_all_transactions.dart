import 'package:budget_tracker/models/category/category_model.dart';
import 'package:budget_tracker/screens/home/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/home/recent_transactions/recent_transactions_cubit.dart';

class ViewAllTransactionScreen extends StatelessWidget {
  const ViewAllTransactionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new, size: 20)),
        title:
            Text('Transactions', style: Theme.of(context).textTheme.bodyLarge!),
      ),
      body: BlocBuilder<RecentTransactionsCubit, RecentTransactionsState>(
        builder: (context, state) {
          if (state is RecentTransactionsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RecentTransactionsLoadedState) {
            final transactions = state.transactions.reversed.toList();
            return ListView.builder(
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
                    date: transaction.date,
                  ),
                );
              },
              itemCount: transactions.length,
            );
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
    );
  }
}
