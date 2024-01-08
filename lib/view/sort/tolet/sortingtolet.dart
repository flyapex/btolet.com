import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:btolet/view/sort/location_small.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'element.dart';

class SortingTolet extends StatefulWidget {
  const SortingTolet({super.key});

  @override
  State<SortingTolet> createState() => _SortingToletState();
}

class _SortingToletState extends State<SortingTolet> {
  ToletController toletController = Get.find();
  @override
  void initState() {
    toletController.sortingPostCount();
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
                          toletController.sortingPostCount();

                          Get.to(() => const SortPostList());
                        },
                        child: Obx(
                          () => Text(
                            "Show ${toletController.totalResult}  Properties",
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
  ToletController toletController = Get.find();
  double startval1 = 0, endval1 = 50000;
  String priceText = "Any Price";
  sliderText(startval1, endval1) {
    setState(() {
      if (startval1 == 0 && endval1 == 50000) {
        priceText = "Any Price";
      } else if (endval1 == 50000) {
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
                  const LocationSmall(),
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
                    max: 50000,
                    min: 0,
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      setState(() {
                        startval1 = lowerValue;
                        endval1 = upperValue;
                        sliderText(startval1, endval1);

                        toletController.rentmin.value = startval1.toInt();
                        toletController.rentmax.value = endval1.toInt();
                      });
                    },
                    onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                      toletController.sortingPostCount();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 10,
                          alignment: WrapAlignment.spaceEvenly,
                          runAlignment: WrapAlignment.start,
                          children: toletController.categoriesSort.entries
                              .map((entry) {
                            final category = entry.key;
                            final categoryState = entry.value;
                            return CategoryChipSort(
                              category: category,
                              categoryState: categoryState,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(Icons.king_bed_outlined),
                      SizedBox(width: 10),
                      Text('Bedroom'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SortButton(type: 1), // 1 for bed
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(Icons.shower_outlined),
                      SizedBox(width: 10),
                      Text('Bathroom'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SortButton(type: 2), // 2 for bath
                  const SizedBox(height: 20),
                  const Text('Fasalitis'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 10,
                          children: toletController.fasalitisSort.entries
                              .map((entry) {
                            final String text = entry.key;
                            final FasalitisModel fasalitis = entry.value;
                            final categoryState = fasalitis.state;

                            return FasalitisChipSort(
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
