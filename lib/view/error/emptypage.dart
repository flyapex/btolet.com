import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constants/colors.dart';

class EmptyPage extends StatelessWidget {
  final String appBarTitle;
  final String bodyText;
  final String smallText;
  final String lottieasset;
  const EmptyPage({
    super.key,
    required this.appBarTitle,
    required this.bodyText,
    required this.smallText,
    required this.lottieasset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: TextStyle(
            fontSize: s1,
            height: 0.5,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7),
            // fontFamily: 'Roboto',
          ),
        ),
        centerTitle: false,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Feather.chevron_left),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Lottie.asset(
                // 'assets/lottie/soon.json',
                lottieasset,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                // 'Under Development ',
                bodyText,
                style: const TextStyle(
                  fontSize: s1,
                  color: Colors.black,
                ),
              ),
              Text(
                // 'Somming Soon..🤝',
                smallText,
                style: const TextStyle(
                  fontSize: s4,
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
