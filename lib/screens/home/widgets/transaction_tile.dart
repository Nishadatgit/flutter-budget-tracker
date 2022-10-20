import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.tileColor,
    required this.category,
    required this.title,
    required this.amount,
    required this.date,
  });
  final Color tileColor;
  final String category;
  final String title;
  final double amount;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM').format(date);
    final formattedDay = DateFormat('EEEE').format(date).substring(0, 4);
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(.3),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        minLeadingWidth: 60,
        minVerticalPadding: 0,
        leading: Text(
          "$formattedDate\n$formattedDay",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 19),
        ),
        subtitle: Text(
          category,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 14, color: Colors.grey),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            "\$$amount",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 18, color: tileColor),
          ),
        ),
      ),
    );
  }
}
