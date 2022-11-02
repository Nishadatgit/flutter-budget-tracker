
import 'package:flutter/material.dart';

class CardInfoWidget extends StatelessWidget {
  const CardInfoWidget({
    super.key,
    required this.amount,
  });
  final double amount;

  @override
  Widget build(BuildContext context) {
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
                  "Your Balance",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                Text("\$$amount",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 40)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
