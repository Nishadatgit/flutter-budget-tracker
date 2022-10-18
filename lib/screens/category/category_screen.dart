// ignore_for_file: use_build_context_synchronously

import 'package:budget_tracker/db/category_db/category_db.dart';
import 'package:budget_tracker/logic/category/category screen/category_cubit.dart';
import 'package:budget_tracker/logic/category/category%20selector/cubit/category_selector_cubit.dart';
import 'package:budget_tracker/models/category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/category_type_radio_button_widget.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController categoryNameEditController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryCubit>(context).fetchCategories();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Category",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is CategoryDeletedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Item deleted")));
            } else if (state is CategoryDeleteErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NoCategoriesState) {
              return const Center(
                child: Text("No data"),
              );
            } else if (state is CategoriesLoadedState) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      final category = state.categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(category.name.toUpperCase()),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  categoryNameEditController.text =
                                      category.name;
                                  BlocProvider.of<CategorySelectorCubit>(
                                          context)
                                      .changeValue(category.categoryType);
                                  showEditCategoryBottomSheet(
                                      context, category.id);
                                },
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                              ),
                              IconButton(
                                onPressed: () {
                                  final newCategory = CategoryModel(
                                      categoryType: category.categoryType,
                                      name: category.name,
                                      isDeleted: true,
                                      id: category.id);
                                  BlocProvider.of<CategoryCubit>(context)
                                      .deleteCategory(category.id, newCategory);
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.categories.length,
                  ),
                ),
              );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
        floatingActionButton: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50,
          height: 50,
          child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                showAddCategoryBottomSheet(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              )),
        ));
  }

  void showAddCategoryBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add Category",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: categoryNameController,
                      textCapitalization: TextCapitalization.characters,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Category Name',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const CategoryTypeRadioButtonWidget(),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final selectedCategoryType =
                          BlocProvider.of<CategorySelectorCubit>(context).state;
                      if (categoryNameController.text.isNotEmpty) {
                        final CategoryModel categoryModel = CategoryModel(
                            name: categoryNameController.text,
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            categoryType: selectedCategoryType);
                        await CategoryDb().insertCategory(categoryModel);
                        BlocProvider.of<CategoryCubit>(context)
                            .fetchCategories();
                        categoryNameController.clear();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Add"),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void showEditCategoryBottomSheet(BuildContext context, String id) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add Category",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: categoryNameEditController,
                      textCapitalization: TextCapitalization.characters,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Category Name',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const CategoryTypeRadioButtonWidget(),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final selectedCategoryType =
                          BlocProvider.of<CategorySelectorCubit>(context).state;
                      if (categoryNameEditController.text.isNotEmpty) {
                        final CategoryModel categoryModel = CategoryModel(
                            name: categoryNameEditController.text,
                            id: id,
                            categoryType: selectedCategoryType);
                        await CategoryDb().insertCategory(categoryModel);
                        BlocProvider.of<CategoryCubit>(context)
                            .fetchCategories();
                        categoryNameEditController.clear();
                        Navigator.of(context).pop();
                      } else {
                        return;
                      }
                    },
                    child: const Text("Add"),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
