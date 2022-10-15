import 'package:budget_tracker/logic/cubit/theme_cubit.dart';
import 'package:budget_tracker/themes/dark_theme.dart';
import 'package:budget_tracker/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                _scaffoldkey.currentState!.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).iconTheme.color,
              )),
          elevation: 0,
          toolbarHeight: 80,
          title: Text(
            "Hello, Nishad",
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 30),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CardInfoWidget(
                  width: width,
                  amount: 20000,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        drawer: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, state) {
            return Drawer(
              backgroundColor:
                  state == darkTheme ? Color(0xff302d43) : Colors.white,
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
                    leading: IconButton(
                      onPressed: () {
                        BlocProvider.of<ThemeCubit>(context).switchTheme();
                      },
                      icon: BlocBuilder<ThemeCubit, ThemeData>(
                        builder: (context, state) => Icon(
                          state == darkTheme
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          color: Theme.of(context).iconTheme.color,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
                image: NetworkImage(
                    "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_960_720.jpg"),
                fit: BoxFit.cover),
          ),
        ),
        const Positioned(
            left: 20,
            bottom: 20,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/images/mypic.jpg"),
            ))
      ],
    );
  }
}

class CardInfoWidget extends StatelessWidget {
  const CardInfoWidget({
    super.key,
    required this.width,
    required this.amount,
  });
  final double amount;

  final double width;

  @override
  Widget build(BuildContext context) {
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
                // stops: [0.2, 0.5, 0.9],
                colors: [Color(0xff6953f7), Colors.purple, Color(0xffcd4ff7)],
              ),
              color: Colors.grey[300]!.withOpacity(0.3),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            width: width * .8,
            height: width * 0.44,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Balance",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Text("\$$amount",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 29)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
