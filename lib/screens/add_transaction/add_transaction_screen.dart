import 'package:budget_tracker/db/transaction_db/transaction_db.dart';
import 'package:budget_tracker/logic/add_transaction/add_transaction_cubit.dart';
import 'package:budget_tracker/logic/category/category%20screen/category_cubit.dart';
import 'package:budget_tracker/logic/home/cubit/recent_transactions_cubit.dart';
import 'package:budget_tracker/models/category/category_model.dart';
import 'package:budget_tracker/models/transaction/transaction_model.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({super.key});
  DateTime? selectedDate;
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  ValueNotifier<CategoryModel?> selectedCategoryModel = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryCubit>(context).fetchCategories();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Transaction",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: BlocConsumer<AddTransactionCubit, AddTransactionState>(
          builder: (ctx, state) {
            if (state is AddingTransaction) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DelayedDisplay(
                    child: TextField(
                      controller: purposeController,
                      decoration: const InputDecoration(hintText: 'Purpose'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DelayedDisplay(
                    child: TextField(
                      controller: amountController,
                      decoration: const InputDecoration(hintText: 'Amount'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DelayedDisplay(
                    child: TextField(
                      controller: dateController,
                      readOnly: true,
                      onTap: () {
                        showCustomDatePicker(context);
                      },
                      decoration: const InputDecoration(hintText: 'Date'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      BlocBuilder<CategoryCubit, CategoryState>(
                        builder: (context, state) {
                          if (state is CategoriesLoadedState) {
                            final items = state.categories;
                            return SizedBox(
                              width: 230,
                              child: ValueListenableBuilder(
                                valueListenable: selectedCategoryModel,
                                builder: (context, value, child) {
                                  return DelayedDisplay(
                                    child: DropdownButton(
                                        underline: const SizedBox(),
                                        dropdownColor:
                                            Theme.of(context).brightness ==
                                                    Brightness.light
                                                ? Colors.purple
                                                : Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                        value: selectedCategoryModel.value,
                                        hint: const Text("Select a category"),
                                        items: items
                                            .map(
                                              (e) => DropdownMenuItem<
                                                  CategoryModel>(
                                                value: e,
                                                child: Text(
                                                  e.name.toUpperCase(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 16),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          if (value == null) {
                                            return;
                                          } else {
                                            selectedCategoryModel.value = value;
                                          }
                                        }),
                                  );
                                },
                              ),
                            );
                          } else if (state is LoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const Text("No categories available");
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final isvalidated = validateForm(context);
                          if (isvalidated == true) {
                            final navigator = Navigator.of(context);
                            final amount =
                                double.parse(amountController.text.trim());
                            final purpose = purposeController.text
                                .toLowerCase()
                                .trimRight();
                            final categoryModel = selectedCategoryModel.value!;
                            final date = selectedDate!;
                            final model = TransactionModel(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              purpose: purpose,
                              amount: amount,
                              category: categoryModel,
                              date: date,
                            );
                            await BlocProvider.of<AddTransactionCubit>(context)
                                .addTransaction(model);

                            // ignore: use_build_context_synchronously
                            BlocProvider.of<RecentTransactionsCubit>(context)
                                .fetchAllRecentTransactions();
                            navigator.pop();
                            //add to db
                          }
                        },
                        child: Text(
                          "Add",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state is AddedTransaction) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Added transaction",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
        ));
  }

  void showCustomDatePicker(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        initialDate: selectedDate != null ? selectedDate! : DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 30)),
        lastDate: DateTime.now());
    if (date == null) {
      return;
    } else {
      final formattedDay = DateFormat('EEEE').format(date);
      final formattedDate = DateFormat("dd/MM/yyyy").format(date);
      dateController.text = "$formattedDate -- $formattedDay";
      selectedDate = date;
    }
  }

  bool validateForm(BuildContext context) {
    final amount = amountController.text.trim();
    final purpose = purposeController.text.toLowerCase().trimRight();
    final categoryModel = selectedCategoryModel.value;
    final date = selectedDate;
    if (date != null && categoryModel != null) {
      if (amount != "" && purpose != "") {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            backgroundColor: Colors.orange,
            content: Row(
              children: [
                Text(
                  "Fields cannot be empty",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, color: Colors.white),
                ),
                const Spacer(),
                Icon(
                  Icons.warning,
                  color: Theme.of(context).iconTheme.color,
                )
              ],
            ),
          ),
        );
        return false;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.orange,
          content: Row(
            children: [
              Text(
                "Fields cannot be empty",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16, color: Colors.white),
              ),
              const Spacer(),
              Icon(
                Icons.warning,
                color: Theme.of(context).iconTheme.color,
              )
            ],
          ),
        ),
      );
      return false;
    }
  }
}
