import 'package:budget_tracker/logic/theme/theme_cubit.dart';
import 'package:budget_tracker/screens/category/category_screen.dart';
import 'package:budget_tracker/screens/home/widgets/card_info_widget.dart';
import 'package:budget_tracker/screens/home/widgets/drawer_header.dart';
import 'package:budget_tracker/screens/home/widgets/transaction_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  final ValueNotifier<bool> isScrollingForward = ValueNotifier(false);
  late ScrollController scrollController;

  late AnimationController animationController;

  late Animation<double> animation;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          isScrollingForward.value = true;
        } else if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          isScrollingForward.value = false;
          isScrollingForward.notifyListeners();
        }
      });

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
        } else {
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
            child: Column(
              children: [
                const DrawerHeaderWidget(),
                ListTile(
                  onTap: () {
                    _scaffoldkey.currentState!.closeDrawer();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => CategoryScreen()));
                  },
                  tileColor: Colors.white.withOpacity(0.3),
                  title: Text(
                    "Manage Categories",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 5),
                ListTile(
                  tileColor: Colors.white.withOpacity(0.3),
                  onTap: () {
                    _scaffoldkey.currentState!.closeDrawer();
                  },
                  title: Text(
                    "Reports",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
                  ),
                )
              ],
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
            Text(
              "Recent Transactions",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (ctx, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TransactionTile(
                    title: "Rent paid",
                    amount: 2000,
                    category: 'Rent',
                    tileColor: Colors.red,
                  ),
                ),
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: isScrollingForward,
          builder: (context, bool value, _) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: value != true ? 55 : 0,
              height: value != true ? 55 : 0,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: value != true
                    ? const Icon(
                        Icons.add,
                        color: Colors.black,
                      )
                    : null,
              ),
            );
          }),
    );
  }
}
