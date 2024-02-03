import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chips.dart';

class FacilitiesPro extends StatelessWidget {
  const FacilitiesPro({super.key});

  @override
  Widget build(BuildContext context) {
    ProController proController = Get.find();
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Aminities',
              style: TextStyle(
                letterSpacing: 0.7,
                color: Colors.black.withOpacity(0.6),
                fontSize: s3,
              ),
            ).paddingOnly(bottom: 2),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Wrap(
                spacing: 10,
                children: proController.fasalitis.entries.map((entry) {
                  final String text = entry.key;
                  final FasalitisModel fasalitis = entry.value;
                  final categoryState = fasalitis.state;

                  return FasalitisChipPro(
                    text: text,
                    icon: fasalitis.icon,
                    categoryState: categoryState,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
