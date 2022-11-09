import 'package:budget_tracker/logic/home/todays_expense/todays_expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardInfoWidget extends StatelessWidget {
  const CardInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodaysExpenseCubit>(context).fetchTodaysExpense();
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.white.withOpacity(0.2),
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff6953f7), Colors.purple, Color(0xffcd4ff7)],
              ),
              color: Colors.grey[300]!.withOpacity(0.3),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            width: width * .8,
            height: width * 0.44,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Todays Expense",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                BlocBuilder<TodaysExpenseCubit, TodaysExpenseState>(
                  builder: (context, state) {
                    if (state is TodaysExpenseLoaded) {
                      return Text("\$ ${state.amount}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 35));
                    } else {
                      return const SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
