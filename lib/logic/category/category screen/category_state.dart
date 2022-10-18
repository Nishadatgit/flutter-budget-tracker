part of 'category_cubit.dart';

class CategoryState {}

class LoadingState extends CategoryState {}

class NoCategoriesState extends CategoryState {}

class CategoryDeletedState extends CategoryState {
  
}

class CategoryDeleteErrorState extends CategoryState {
  final String message;

  CategoryDeleteErrorState(this.message);
}

class CategoriesLoadedState extends CategoryState {
  final List<CategoryModel> categories;

  CategoriesLoadedState(this.categories);
}
