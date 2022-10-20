import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 70),
            child: TextAnimation(text: 'Nothing here..\n🔎'),
          ),
        ),
        Positioned(
            bottom: 95,
            right: 140,
            child: Text(
              "Click to add category",
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

class TextAnimation extends StatefulWidget {
  const TextAnimation({super.key, required this.text});
  final String text;

  @override
  State<TextAnimation> createState() => _TextAnimationState();
}

class _TextAnimationState extends State<TextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));
    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceIn,
        reverseCurve: Curves.easeIn);
    animation = Tween<double>(begin: .5, end: 1.7).animate(curvedAnimation)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: animation.value * 10.clamp(90, 100),
          width: 250,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(5, 0),
                  color: Theme.of(context)
                      .primaryColor
                      .withOpacity(animation.value.clamp(0, .8)),
                  blurRadius: 10,
                  blurStyle: BlurStyle.outer)
            ],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Transform.scale(
          // scaleY: animation.value.clamp(0, 20),
          // scaleX: animation.value.clamp(0, 30),
          scale: animation.value,
          child: Text(
            widget.text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: animation.value.clamp(30, 45)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
