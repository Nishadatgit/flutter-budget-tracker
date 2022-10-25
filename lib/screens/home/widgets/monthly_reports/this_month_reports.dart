import 'package:animations/animations.dart';
import 'package:budget_tracker/logic/home/this_month/this_month_cubit.dart';
import 'package:budget_tracker/screens/home/widgets/monthly_reports/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThisMonthReportsScreen extends StatelessWidget {
  const ThisMonthReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThisMonthCubit>(context).getThisMonthData();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            )),
        title:
            Text("This Month", style: Theme.of(context).textTheme.bodyLarge!),
      ),
      body: BlocBuilder<ThisMonthCubit, ThisMonthState>(
        builder: (context, state) {
          if (state is ThisMonthLoaded) {
            return ListView(
              children: [
                OpenContainer(
                  closedColor: Colors.transparent,
                  closedBuilder: (context, action) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: width * 0.16,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Income",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Spacer(),
                            Text(
                              state.data['total_income'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  openBuilder: (context, action) {
                    return ThisMonthDetilsScreen(
                        title: "Income",
                        transactions: state.data['income_transactions']);
                  },
                ),
                OpenContainer(
                  closedColor: Colors.transparent,
                  closedBuilder: (context, action) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: width * 0.16,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Expense",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Spacer(),
                            Text(
                              state.data['total_expense'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  openBuilder: (context, action) {
                    return ThisMonthDetilsScreen(
                        title: "Expense",
                        transactions: state.data['expense_transactions']);
                  },
                ),
              ],
            );
          } else if (state is ThisMonthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}
