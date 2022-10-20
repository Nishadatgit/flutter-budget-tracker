// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:budget_tracker/models/category/category_model.dart';

class CategorySelectorCubit extends Cubit<CategoryType> {
  CategorySelectorCubit() : super(CategoryType.income);

  void changeValue(CategoryType value) => emit(value);
}
