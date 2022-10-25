import 'package:animations/animations.dart';
import 'package:budget_tracker/logic/home/cubit/recent_transactions_cubit.dart';
import 'package:budget_tracker/logic/theme/theme_cubit.dart';
import 'package:budget_tracker/models/category/category_model.dart';
import 'package:budget_tracker/screens/add_transaction/add_transaction_screen.dart';
import 'package:budget_tracker/screens/category/category_screen.dart';
import 'package:budget_tracker/screens/home/widgets/card_info_widget.dart';
import 'package:budget_tracker/screens/home/widgets/drawer_header.dart';
import 'package:budget_tracker/screens/home/widgets/transaction_tile.dart';
import 'package:budget_tracker/screens/reports_screen/reports_screen.dart';
import 'package:budget_tracker/screens/view_all_transactions_screen/view_all_transactions.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  final ValueNotifier<bool> isScrollingForward = ValueNotifier(false);
  late ScrollController scrollController;

  late AnimationController animationController;
  late AnimationController floatingAnimationController;
  late Animation<double> animation;
  late Animation<Offset> floatingAnimation;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    floatingAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    final curvedFloatingAnimation = CurvedAnimation(
        parent: floatingAnimationController,
        curve: Curves.ease,
        reverseCurve: Curves.ease);
    floatingAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: const Offset(0, 0))
            .animate(curvedFloatingAnimation);

    //Scroll controller
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          floatingAnimationController.reverse();
        } else if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          floatingAnimationController.forward();
        }
      });
    floatingAnimationController.forward();
    //
    BlocProvider.of<RecentTransactionsCubit>(context)
        .fetchAllRecentTransactions();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: 100,
      onDrawerChanged: (value) {
        if (value == false) {
          animationController.reverse();
          floatingAnimationController.forward();
        } else {
          floatingAnimationController.reverse();
          animationController.forward();
        }
      },
      key: _scaffoldkey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () {
              _scaffoldkey.currentState!.openDrawer();
            },
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow,
              progress: animation,
              color: Theme.of(context).iconTheme.color,
            )),
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          "Hello, Nishad",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 30),
        ),
      ),
      drawer: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return Drawer(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  const DrawerHeaderWidget(),
                  OpenContainer(
                    useRootNavigator: true,
                    openColor: const Color(0xff302d43),
                    closedColor: Colors.transparent,
                    openBuilder: (context, action) {
                      return CategoryScreen();
                    },
                    closedBuilder: (context, action) {
                      return Container(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        height: 50,
                        alignment: Alignment.center,
                        child: Hero(
                          tag: 'name',
                          child: Text(
                            "Categories",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  OpenContainer(
                    closedColor: Colors.transparent,
                    useRootNavigator: true,
                    closedBuilder: (context, action) {
                      return Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        child: Hero(
                          tag: "name2",
                          child: Text(
                            "Reports",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 16),
                          ),
                        ),
                      );
                    },
                    openBuilder: (context, action) {
                      return const ReportsScreen();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CardInfoWidget(
                width: width,
                amount: 20000,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent transactions",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 22),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ViewAllTransactionScreen()));
                  },
                  child: Text(
                    "View all",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocConsumer<RecentTransactionsCubit,
                  RecentTransactionsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RecentTransactionsLoadedState) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: DelayedDisplay(
                        child: ListView.builder(
                          controller: scrollController,
                          itemBuilder: (ctx, index) {
                            final transaction =
                                state.transactions.reversed.toList()[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TransactionTile(
                                title: transaction.purpose,
                                amount: transaction.amount,
                                category: transaction.category.name,
                                tileColor: transaction.category.categoryType ==
                                        CategoryType.expense
                                    ? Colors.red
                                    : Colors.green,
                                date: transaction.date,
                              ),
                            );
                          },
                          itemCount: state.transactions.length > 20
                              ? 20
                              : state.transactions.length,
                        ),
                      ),
                    );
                  } else if (state is RecentTransactionsLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is RecentTransactionsEmptyState) {
                    return Center(
                      child: Text(
                        "No recent transactions",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  } else {
                    return const Center(child: Text("Something went wrong"));
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: SlideTransition(
        position: floatingAnimation,
        child: OpenContainer(
          closedColor: Theme.of(context).primaryColor,
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          middleColor: const Color(0xff302d43),
          transitionType: ContainerTransitionType.fade,
          transitionDuration: const Duration(milliseconds: 500),
          closedBuilder: (context, action) {
            return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 50,
                height: 50,
                child: const Hero(
                  tag: 'icon',
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ));
          },
          openBuilder: (context, action) {
            return AddTransactionScreen();
          },
        ),
      ),
    );
  }
}
