import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Center(child: Text("Nothing here")),
        Positioned(
            bottom: 95,
            right: 140,
            child: Text(
              "Click here to add a category",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
            )),
        Positioned(
          bottom: 40,
          right: 50,
          child: Image.asset(
            "assets/images/arrow.png",
            height: 150,
            width: 100,
          ),
        )
      ],
    );
  }
}
