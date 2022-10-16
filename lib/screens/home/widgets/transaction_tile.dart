import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.tileColor,
    required this.category,
    required this.title,
    required this.amount,
  });
  final Color tileColor;
  final String category;
  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
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
          "12/02\nWED",
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
