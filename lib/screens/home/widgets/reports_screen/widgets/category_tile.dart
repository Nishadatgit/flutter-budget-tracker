import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.tileName,
    required this.count,
  });
  final String tileName;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tileName.toUpperCase(),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
          ),
          Text(
            "$count transactions",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(),
          ),
        ],
      ),
    );
  }
}
