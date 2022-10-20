import 'package:budget_tracker/models/category/category_model.dart';
import 'package:hive_flutter/adapters.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String purpose;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final CategoryModel category;

  @HiveField(4)
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.purpose,
    required this.amount,
    required this.category,
    required this.date,
  });
}
