// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:budget_tracker/db/category_db/category_db.dart';
import 'package:budget_tracker/models/category/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryDb categoryDb = CategoryDb();

  CategoryCubit() : super(LoadingState());

  void fetchCategories() async {
    emit(LoadingState());
    final datas = await categoryDb.getCategories();
    if (datas.isEmpty) {
      emit(NoCategoriesState());
    } else {
      emit(CategoriesLoadedState(datas));
    }
  }

  void deleteCategory(String id,CategoryModel model) async {
    try {
      await categoryDb.hideCategory(id,model);
      emit(CategoryDeletedState());
      fetchCategories();
    } catch (e) {
      emit(CategoryDeleteErrorState(e.toString()));
      fetchCategories();
    }
  }
}
