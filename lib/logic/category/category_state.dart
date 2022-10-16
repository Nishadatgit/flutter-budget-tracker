part of 'category_cubit.dart';

class CategoryState {}

class LoadingState extends CategoryState {}

class NoCategoriesState extends CategoryState {}

class CategoriesLoadedState extends CategoryState {
  final List<CategoryModel> categories;

  CategoriesLoadedState(this.categories);
}
