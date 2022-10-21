import 'package:budget_tracker/db/category_db/category_db.dart';
import 'package:budget_tracker/logic/category/category screen/category_cubit.dart';
import 'package:budget_tracker/logic/category/category%20selector/cubit/category_selector_cubit.dart';
import 'package:budget_tracker/models/category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'widgets/category_type_radio_button_widget.dart';
import 'widgets/no_data_widget.dart';

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
          scrolledUnderElevation: 1,
          elevation: 0,
          title: Hero(
            tag: 'name',
            child: Text(
              "Categories",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocConsumer<CategoryCubit, CategoryState>(
            listener: (context, state) {
              if (state is CategoryDeletedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 1),
                    content: Text(
                      "Item deleted",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              } else if (state is CategoryDeleteErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    duration: const Duration(seconds: 1),
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NoCategoriesState) {
                return const Center(
                  child: NoDataWidget(),
                );
              } else if (state is CategoriesLoadedState) {
                return SizedBox(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      final category = state.categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: DelayedDisplay(
                          slidingBeginOffset: const Offset(0.0, 0.5),
                          fadingDuration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Slidable(
                              closeOnScroll: true,
                              endActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  openThreshold: 0.5,
                                  children: [
                                    SlidableAction(
                                        onPressed: (ctx) {
                                          categoryNameEditController.text =
                                              category.name;
                                          BlocProvider.of<
                                                      CategorySelectorCubit>(
                                                  context)
                                              .changeValue(
                                                  category.categoryType);
                                          showEditCategoryBottomSheet(
                                              context, category.id);
                                        },
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.blue,
                                        icon: Icons.edit),
                                    SlidableAction(
                                      onPressed: (context) {
                                        final newCategory = CategoryModel(
                                            categoryType: category.categoryType,
                                            name: category.name,
                                            isDeleted: true,
                                            id: category.id);
                                        BlocProvider.of<CategoryCubit>(context)
                                            .deleteCategory(
                                                category.id, newCategory);
                                      },
                                      icon: Icons.delete,
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.red,
                                    )
                                  ]),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color: category.categoryType ==
                                              CategoryType.income
                                          ? Colors.green[300]!.withOpacity(0.8)
                                          : Colors.red[300]!.withOpacity(0.8)),
                                ),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(category.name.toUpperCase()),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: state.categories.length,
                  ),
                );
              } else {
                return const Center(child: Text('Something went wrong'));
              }
            },
          ),
        ),
        floatingActionButton: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50,
          height: 50,
          child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () async {
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
                      autofocus: true,
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
                        final navigator = Navigator.of(context);
                        final CategoryModel categoryModel = CategoryModel(
                            name: categoryNameController.text.toLowerCase(),
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            categoryType: selectedCategoryType);
                        await CategoryDb().insertCategory(categoryModel);
                        // ignore: use_build_context_synchronously
                        BlocProvider.of<CategoryCubit>(context)
                            .fetchCategories();
                        categoryNameController.clear();
                        navigator.pop();
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
                        final navigator = Navigator.of(context);
                        final CategoryModel categoryModel = CategoryModel(
                            name: categoryNameEditController.text.toLowerCase(),
                            id: id,
                            categoryType: selectedCategoryType);
                        await CategoryDb().insertCategory(categoryModel);
                        // ignore: use_build_context_synchronously
                        BlocProvider.of<CategoryCubit>(context)
                            .fetchCategories();

                        categoryNameEditController.clear();
                        navigator.pop();
                      } else {
                        return;
                      }
                    },
                    child: const Text("Edit"),
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
