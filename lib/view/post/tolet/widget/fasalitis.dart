import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chips.dart';

class Facilities extends StatelessWidget {
  const Facilities({super.key});

  @override
  Widget build(BuildContext context) {
    ToletController toletController = Get.find();
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Facilities(op)',
              style: TextStyle(
                fontSize: s3,
                // height: .8,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Wrap(
                spacing: 10,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                children: toletController.fasalitis.entries.map((entry) {
                  final String text = entry.key;
                  final FasalitisModel fasalitis = entry.value;
                  final categoryState = fasalitis.state;
                  return FasalitisChip(
                    text: text,
                    icon: fasalitis.icon,
                    categoryState: categoryState,
                  );
                }).toList(),
              ),
            ),
          ],
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     // Column 1 (4 items)
        //     Expanded(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children:
        //             toletController.fasalitis.entries.take(4).map((entry) {
        //           final String text = entry.key;
        //           final FasalitisModel fasalitis = entry.value;
        //           final categoryState = fasalitis.state;
        //           return FasalitisChip(
        //             text: text,
        //             icon: fasalitis.icon,
        //             categoryState: categoryState,
        //           );
        //         }).toList(),
        //       ),
        //     ),
        //     // Column 2 (3 items)
        //     Expanded(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: toletController.fasalitis.entries
        //             .skip(4)
        //             .take(3)
        //             .map((entry) {
        //           final String text = entry.key;
        //           final FasalitisModel fasalitis = entry.value;
        //           final categoryState = fasalitis.state;
        //           return FasalitisChip(
        //             text: text,
        //             icon: fasalitis.icon,
        //             categoryState: categoryState,
        //           );
        //         }).toList(),
        //       ),
        //     ),
        //     // Column 3 (3 items)
        //     Expanded(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: toletController.fasalitis.entries
        //             .skip(7)
        //             .take(3)
        //             .map((entry) {
        //           final String text = entry.key;
        //           final FasalitisModel fasalitis = entry.value;
        //           final categoryState = fasalitis.state;
        //           return FasalitisChip(
        //             text: text,
        //             icon: fasalitis.icon,
        //             categoryState: categoryState,
        //           );
        //         }).toList(),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
