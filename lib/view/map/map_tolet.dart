import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapTolet extends StatelessWidget {
  const MapTolet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              'Map Tolet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
