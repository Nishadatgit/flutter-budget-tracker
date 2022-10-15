import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Hello, Nishad",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
                backgroundColor: Colors.white, padding: EdgeInsets.zero),
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 22,
              child: const Icon(Icons.person),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
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
                          colors: [
                            Color(0xff6953f7),
                            Colors.purple,
                            Color(0xffcd4ff7)
                          ],
                        ),
                        color: Colors.grey[300]!.withOpacity(0.3),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
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
                                .copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          Text("\$3000",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 29)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
