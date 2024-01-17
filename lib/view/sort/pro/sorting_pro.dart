import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:btolet/view/map/location_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'element.dart';

class SortingPro extends StatefulWidget {
  const SortingPro({super.key});

  @override
  State<SortingPro> createState() => _SortingProState();
}

class _SortingProState extends State<SortingPro> {
  ProController proController = Get.find();
  @override
  void initState() {
    proController.sortingPostCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (opu) {},
      child: AnimatedContainer(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 100),
        height: Get.height - 80,
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.only(top: 5, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: SortHere(),
            ),
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: const Center(
                          child: Text(
                            "Clear All",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.orange,
                          ),
                        ),
                        onPressed: () async {
                          proController.sortingPostCount();

                          Get.to(() => const SortPostListPro());
                        },
                        child: Obx(
                          () => Text(
                            "Show ${proController.totalResult}  Properties",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SortHere extends StatefulWidget {
  const SortHere({super.key});

  @override
  State<SortHere> createState() => _SortHereState();
}

class _SortHereState extends State<SortHere> with TickerProviderStateMixin {
  ProController proController = Get.find();
  double startval1 = 100000, endval1 = 10000000;
  String priceText = "Any Price";
  sliderText(startval1, endval1) {
    setState(() {
      if (startval1 == 100000 && endval1 == 10000000) {
        priceText = "Any Price";
      } else if (endval1 == 10000000) {
        priceText =
            '৳ ${NumberFormat.decimalPattern().format(startval1.toInt())} to ${NumberFormat.decimalPattern().format(endval1.toInt())}+/month';
      } else {
        priceText =
            '৳ ${NumberFormat.decimalPattern().format(startval1.toInt())} to ${NumberFormat.decimalPattern().format(endval1.toInt())}/month';
      }
    });
  }

  double categorySize = 117.0;
  @override
  Widget build(BuildContext context) {
    // double space = 20.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const LocationSmall(),
                  const Location(),
                  Center(
                    child: FittedBox(
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text(
                            priceText,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FlutterSlider(
                    step: const FlutterSliderStep(step: 500),
                    trackBar: FlutterSliderTrackBar(
                      activeTrackBarHeight: 10,
                      inactiveTrackBarHeight: 10,
                      inactiveTrackBar: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueAccent.withOpacity(0.2),
                      ),
                      activeTrackBar: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff537FE7),
                      ),
                    ),
                    handler: FlutterSliderHandler(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    rightHandler: FlutterSliderHandler(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    handlerAnimation: const FlutterSliderHandlerAnimation(
                      duration: Duration(milliseconds: 100),
                    ),
                    tooltip: FlutterSliderTooltip(disabled: true),
                    handlerHeight: 28,
                    handlerWidth: 28,
                    values: [startval1, endval1],
                    rangeSlider: true,
                    max: 10000000,
                    min: 100000,
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      setState(() {
                        startval1 = lowerValue;
                        endval1 = upperValue;
                        sliderText(startval1, endval1);

                        proController.rentmin.value = startval1.toInt();
                        proController.rentmax.value = endval1.toInt();
                      });
                    },
                    onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                      proController.sortingPostCount();
                    },
                  ),
                  // Text(
                  //   'Category',
                  //   style: TextStyle(
                  //     color: Colors.black.withOpacity(0.5),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 10,
                          alignment: WrapAlignment.spaceEvenly,
                          runAlignment: WrapAlignment.start,
                          children:
                              proController.categoriesSort.entries.map((entry) {
                            final category = entry.key;
                            final categoryState = entry.value;
                            return CategoryChipPro(
                              category: category,
                              categoryState: categoryState,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.bed_outlined,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Beds',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SortButtonPro(type: 1), // 1 for bed
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.shower_outlined,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Baths',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SortButtonPro(type: 2), // 2 for bath
                  // const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.kitchen_outlined,
                  //       color: Colors.black.withOpacity(0.7),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     Text(
                  //       'kitchen',
                  //       style: TextStyle(
                  //         color: Colors.black.withOpacity(0.7),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 20),
                  // const SortButtonPro(type: 3), // 3 for kitchen
                  // const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.dining_outlined,
                  //       color: Colors.black.withOpacity(0.7),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     Text(
                  //       'Dining',
                  //       style: TextStyle(
                  //         color: Colors.black.withOpacity(0.7),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 20),
                  // const SortButtonPro(type: 4), // 4 for Dining

                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Aminities'),
                      Obx(
                        () {
                          final trueAmenitiesCount = proController
                              .fasalitisSort.values
                              .where((model) => model.state.value == true)
                              .length;

                          return trueAmenitiesCount > 0
                              ? Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    '$trueAmenitiesCount selected',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : const SizedBox();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 10,
                          children:
                              proController.fasalitisSort.entries.map((entry) {
                            final String text = entry.key;
                            final FasalitisModel fasalitis = entry.value;
                            final categoryState = fasalitis.state;

                            return FasalitisChipProSort(
                              text: text,
                              icon: fasalitis.icon,
                              categoryState: categoryState,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
