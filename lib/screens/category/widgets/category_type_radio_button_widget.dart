import 'package:budget_tracker/logic/category/category%20selector/cubit/category_selector_cubit.dart';
import 'package:budget_tracker/models/category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTypeRadioButtonWidget extends StatelessWidget {
  const CategoryTypeRadioButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategorySelectorCubit, CategoryType>(
      builder: (context, state) {
        return SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Radio(
                      value: CategoryType.income,
                      groupValue: state,
                      onChanged: (value) {
                        BlocProvider.of<CategorySelectorCubit>(
                                context)
                            .changeValue(value!);
                      }),
                  Text(
                    "Income",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: CategoryType.expense,
                      groupValue: state,
                      onChanged: (value) {
                        BlocProvider.of<CategorySelectorCubit>(
                                context)
                            .changeValue(value!);
                      }),
                  Text(
                    "Expense",
                    style: Theme.of(context).textTheme.bodyMedium,
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