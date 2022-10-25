import 'package:animations/animations.dart';
import 'package:budget_tracker/logic/category/category%20screen/category_cubit.dart';
import 'package:budget_tracker/logic/reports/reports_cubit.dart';
import 'package:budget_tracker/screens/home/widgets/reports_screen/view_report.dart';
import 'package:budget_tracker/screens/home/widgets/reports_screen/widgets/category_tile.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReportsCubit>(context).getData();
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'name2',
          child: Text(
            "Category Reports",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<ReportsCubit, ReportsState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ReportsLoaded) {
              final data = state.data;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (ctx, index) {
                  final tileNames = data.keys.toList();
                  final arrayOfTransactions = data.values.toList();
                  return DelayedDisplay(
                    fadingDuration: const Duration(milliseconds: 500),
                    slidingBeginOffset: const Offset(5, 0),
                    child: OpenContainer(
                      closedColor: Colors.transparent,
                      openBuilder: (context, action) {
                        return ViewReport(
                            name: tileNames[index],
                            transactions: arrayOfTransactions[index]);
                      },
                      closedBuilder: (context, action) {
                        return CategoryTile(
                          
                          tileName: tileNames[index],
                          count: arrayOfTransactions[index].length,
                        );
                      },
                    ),
                  );
                },
                itemCount: data.length,
              );
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          },
        ),
      ),
    );
  }
}
