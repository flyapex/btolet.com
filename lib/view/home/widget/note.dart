import 'package:btolet/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class Note extends StatelessWidget {
  const Note({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    return Obx(
      () => Container(
        height: 30,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.black,
              letterSpacing: 0.5,
            ),
            child: Marquee(
              text: userController.note.value,
              // style: const TextStyle(
              //   fontWeight: FontWeight.bold,
              //   color: Colors.white,
              // ),
              scrollAxis: Axis.horizontal,
              // crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 100.0,
              velocity: 100.0,
              pauseAfterRound: const Duration(seconds: 1),
              // startPadding: 10.0,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
        ),
      ),
    );
  }
}
