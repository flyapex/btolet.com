import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:btolet/view/post/tolet%20widget/chips.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Expanded(
        //       child: Wrap(
        //         spacing: 10,
        //         alignment: WrapAlignment.start,
        //         runAlignment: WrapAlignment.start,
        //         children: toletController.fasalitis.entries.map((entry) {
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
        // ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: (toletController.fasalitis.entries.length / 3).ceil(),
        //   itemBuilder: (BuildContext context, int rowIndex) {
        //     int startIndex = rowIndex * 3;
        //     int endIndex = (rowIndex + 1) * 3;
        //     endIndex = endIndex > toletController.fasalitis.entries.length
        //         ? toletController.fasalitis.entries.length
        //         : endIndex;

        //     List<MapEntry<String, FasalitisModel>> entriesList =
        //         toletController.fasalitis.entries.toList();

        //     return Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: entriesList.sublist(startIndex, endIndex).map((entry) {
        //         final String text = entry.key;
        //         final FasalitisModel fasalitis = entry.value;
        //         final categoryState = fasalitis.state;
        //         return Expanded(
        //           child: FasalitisChip(
        //             text: text,
        //             icon: fasalitis.icon,
        //             categoryState: categoryState,
        //           ),
        //         );
        //       }).toList(),
        //     );
        //   },
        // )

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     // Row 1 (3 items)
        //     Expanded(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children:
        //             toletController.fasalitis.entries.take(3).map((entry) {
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     // Row 2 (3 items)
        //     Expanded(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: toletController.fasalitis.entries
        //             .skip(3)
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     // Row 3 (3 items)
        //     Expanded(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: toletController.fasalitis.entries
        //             .skip(6)
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Expanded(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children:
        //             toletController.fasalitis.entries.skip(9).map((entry) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Column 1 (4 items)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    toletController.fasalitis.entries.take(4).map((entry) {
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
            // Column 2 (3 items)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: toletController.fasalitis.entries
                    .skip(4)
                    .take(3)
                    .map((entry) {
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
            // Column 3 (3 items)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: toletController.fasalitis.entries
                    .skip(7)
                    .take(3)
                    .map((entry) {
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
      ],
    );
  }
}
