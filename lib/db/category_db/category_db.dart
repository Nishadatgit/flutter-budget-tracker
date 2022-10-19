import 'package:budget_tracker/core/constants.dart';
import 'package:budget_tracker/models/category/category_model.dart';
import 'package:hive/hive.dart';

class CategoryDb {
  Future<List<CategoryModel>> getCategories() async {
    final box = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);

    final data =
        box.values.where((element) => element.isDeleted != true).toList();

    return data;
  }

  Future<void> insertCategory(CategoryModel item) async {
    final box = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await box.put(item.id, item);
  }

  Future<void> hideCategory(String id, CategoryModel item) async {
    final box = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await box.put(item.id, item);
  }

  Future<void> clearBox() async {
    final box = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    box.clear();
  }

  //this function is never used as we are switching the isDeleted variable true in db while user deletes a category;
  // Future<void> deleteCategory(String id) async {
  //   final box = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  //   await box.delete(id);
  // }
}
