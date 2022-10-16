import 'dart:developer';

import 'package:budget_tracker/core/constants.dart';
import 'package:budget_tracker/models/category/category_model.dart';
import 'package:hive/hive.dart';

class CategoryDb {
  
  Future<List<CategoryModel>> getCategories() async {
    final box = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return box.values.toList();
  }

  
  Future<void> insertCategory(CategoryModel item) async {
    final box = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    final id = await box.add(item);
    log(id.toString());
  }
}
