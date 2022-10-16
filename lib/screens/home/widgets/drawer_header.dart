import 'package:budget_tracker/logic/theme/theme_cubit.dart';
import 'package:budget_tracker/themes/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2)),
        ),
        Positioned(
          left: 20,
          bottom: 30,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/mypic.jpg"),
              ),
              const SizedBox(width: 20),
              Text(
                "Mohamed Nishad kk",
                style: Theme.of(context).textTheme.bodyMedium!,
              )
            ],
          ),
        ),
        Positioned(
          top: 40,
          right: 30,
          child: IconButton(
            onPressed: () {
              BlocProvider.of<ThemeCubit>(context).switchTheme();
            },
            icon: BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, state) => Icon(
                state == darkTheme ? Icons.light_mode : Icons.dark_mode,
                color: Theme.of(context).iconTheme.color,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
