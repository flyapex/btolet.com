import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PropertyHomeTEMP extends StatelessWidget {
  const PropertyHomeTEMP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Lottie.asset(
                'assets/lottie/soon.json',
              ),
            ),
          ),
          const Column(
            children: [
              Text(
                'Under Development ',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              Text(
                'Somming Soon..🤝',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
