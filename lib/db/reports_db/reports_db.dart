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
    final List<String> categories = categoryBox.values
        .where((element) => element.isDeleted == false)
        .map((e) => e.name)
        .toList();
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
}
