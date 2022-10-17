import 'package:budget_tracker/logic/category/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final TextEditingController categoryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryCubit>(context).fetchCategories();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Category",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoCategoriesState) {
            return const Center(child: Text("No data"));
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
      floatingActionButton: SizedBox(
        width: 70,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            showAddCategoryBottomSheet(context);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void showAddCategoryBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      constraints: BoxConstraints.tight(const Size.fromHeight(300)),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add Category",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              ),
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
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          border: const OutlineInputBorder(),
                          label: const Text("Name"),
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith()),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Add"))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
