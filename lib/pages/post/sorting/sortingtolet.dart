import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/widget/btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'widget/element.dart';
import 'widget/sortingtoletpage.dart';

class SortingTolet extends StatefulWidget {
  const SortingTolet({super.key});

  @override
  State<SortingTolet> createState() => _SortingToletState();
}

class _SortingToletState extends State<SortingTolet> {
  PostController postController = Get.find();
  @override
  void initState() {
    postController.sortingPostCount();
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
                          // postController.sortingPostCount();

                          Get.to(() => const ToletSortPage());
                        },
                        child: Obx(
                          () => Text(
                            "Show ${postController.totalResult}  Property",
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
  PostController postController = Get.put(PostController());
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
                        postController.rentmin.value = startval1.toInt();
                        postController.rentmax.value = endval1.toInt();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 10,
                          children:
                              postController.categories.entries.map((entry) {
                            final category = entry.key;
                            final categoryState = entry.value;
                            return CategoryToletChipSortTolet(
                              category: category,
                              categoryState: categoryState,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  // Center(
                  //   child: Stack(
                  //     clipBehavior: Clip.none,
                  //     alignment: Alignment.bottomCenter,
                  //     children: [
                  //       AnimatedContainer(
                  //         duration: const Duration(microseconds: 500),
                  //         width: Get.width,
                  //         height: categorySize,
                  //         child: ShaderMask(
                  //           shaderCallback: (Rect rect) {
                  //             return const LinearGradient(
                  //               begin: Alignment.topCenter,
                  //               end: Alignment.bottomCenter,
                  //               colors: [
                  //                 Colors.purple,
                  //                 Colors.transparent,
                  //                 Colors.transparent,
                  //                 Colors.purple
                  //               ],
                  //               stops: [
                  //                 0.0,
                  //                 0.1,
                  //                 0.9,
                  //                 1.0
                  //               ], // 10% purple, 80% transparent, 10% purple
                  //             ).createShader(rect);
                  //           },
                  //           blendMode: BlendMode.dstOut,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               Expanded(
                  //                 child: Wrap(
                  //                   spacing: 10,
                  //                   children: postController.categories.entries
                  //                       .map((entry) {
                  //                     final category = entry.key;
                  //                     final categoryState = entry.value;
                  //                     return CategoryToletChip(
                  //                       category: category,
                  //                       categoryState: categoryState,
                  //                     );
                  //                   }).toList(),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             print(categorySize);
                  //             categorySize = (categorySize == 117) ? 170 : 117;
                  //           });
                  //         },
                  //         child: Container(
                  //           width: 100,
                  //           height: 45,
                  //           padding: const EdgeInsets.only(top: 15),
                  //           decoration: BoxDecoration(
                  //             color: Colors.transparent,
                  //             borderRadius: BorderRadius.circular(100),
                  //           ),
                  //           child: Center(
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     Text(
                  //                       categorySize == 117
                  //                           ? 'See more'
                  //                           : 'Close',
                  //                       style: const TextStyle(
                  //                         color: Color(0xff083437),
                  //                       ),
                  //                     ),
                  //                     Icon(
                  //                       categorySize == 117
                  //                           ? Feather.chevron_down
                  //                           : Feather.chevron_up,
                  //                       color: const Color(0xff083437),
                  //                       size: 18,
                  //                     )
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                          children: postController.fasalitisTolet.entries
                              .map((entry) {
                            final String text = entry.key;
                            final FasalitisTolet fasalitisTolet = entry.value;
                            final categoryState = fasalitisTolet.state;

                            return FasalitisSortTolet(
                              text: text,
                              icon: fasalitisTolet.icon,
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

          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     height: 50,
          //     margin: const EdgeInsets.only(top: 10, bottom: 10),
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         const Padding(
          //           padding: EdgeInsets.only(left: 20, right: 20),
          //           child: Text(
          //             'Clear All',
          //             style: TextStyle(
          //               fontSize: 18,
          //               color: Colors.black,
          //             ),
          //           ),
          //         ),
          //         Expanded(
          //           child: Center(
          //             child: Container(
          //               padding: const EdgeInsets.only(
          //                   left: 10, right: 10, top: 10, bottom: 10),
          //               decoration: BoxDecoration(
          //                 color: Colors.orange,
          //                 borderRadius: BorderRadius.circular(10),
          //               ),
          //               child: const Text(
          //                 'Show 123,23 Property',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}


// class CatagoryCpx extends StatefulWidget {
//   final String catagory;
//   const CatagoryCpx({
//     super.key,
//     required this.catagory,
//   });

//   @override
//   State<CatagoryCpx> createState() => _CatagoryCpxState();
// }

// class _CatagoryCpxState extends State<CatagoryCpx> {
//   final PostController postController = Get.find();

//   getController() {
//     if (widget.catagory == 'Family') {
//       return postController.family.value;
//     } else if (widget.catagory == 'Bachelor') {
//       return postController.bachelor.value;
//     } else if (widget.catagory == 'Office') {
//       return postController.office.value;
//     } else if (widget.catagory == 'Male Sit') {
//       return postController.sitMale.value;
//     } else if (widget.catagory == 'Female Sit') {
//       return postController.sitFemale.value;
//     } else if (widget.catagory == 'Sub-let') {
//       return postController.sublet.value;
//     } else if (widget.catagory == 'Hostel') {
//       return postController.hostel.value;
//     } else if (widget.catagory == 'Shop') {
//       return postController.shop.value;
//     } else if (widget.catagory == 'Only Garage') {
//       return postController.onlygarage.value;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () {
//         return FilterChip(
//           showCheckmark: false,
//           label: Text(
//             widget.catagory,
//             style: TextStyle(
//               color: Colors.black.withOpacity(0.5),
//             ),
//           ),
//           selected: getController(),
//           onSelected: (value) {
//             if (widget.catagory == 'Family') {
//               postController.family.value = !postController.family.value;
//             } else if (widget.catagory == 'Bachelor') {
//               postController.bachelor.value = !postController.bachelor.value;
//             } else if (widget.catagory == 'Office') {
//               postController.office.value = !postController.office.value;
//             } else if (widget.catagory == 'Male Sit') {
//               postController.sitMale.value = !postController.sitMale.value;
//             } else if (widget.catagory == 'Female Sit') {
//               postController.sitFemale.value = !postController.sitFemale.value;
//             } else if (widget.catagory == 'Sub-let') {
//               postController.sublet.value = !postController.sublet.value;
//             } else if (widget.catagory == 'Hostel') {
//               postController.hostel.value = !postController.hostel.value;
//             } else if (widget.catagory == 'Shop') {
//               postController.shop.value = !postController.shop.value;
//             } else if (widget.catagory == 'Only Garage') {
//               postController.onlygarage.value =
//                   !postController.onlygarage.value;
//             }
//             // postController.allCategoryCheck();
//           },
//           avatar: Icon(
//             getController() ? Icons.check_circle_rounded : Icons.add,
//             color: getController()
//                 ? const Color(0xff0166EE)
//                 : const Color.fromARGB(255, 192, 194, 198),
//           ),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//           side: BorderSide(
//             color: getController()
//                 ? const Color(0xff0166EE)
//                 : Colors.black.withOpacity(0.1),
//           ),
//           elevation: 0.3,
//           selectedShadowColor: Colors.black.withOpacity(0.5),
//           shadowColor: Colors.black.withOpacity(0.5),
//           backgroundColor: Colors.white,
//           selectedColor: Colors.white,
//         );
//       },
//     );
//   }
// }

// class CustomScrollPhysics extends ScrollPhysics {
//   final Function(double) onScroll;

//   const CustomScrollPhysics({required this.onScroll, ScrollPhysics? parent})
//       : super(parent: parent);

//   @override
//   CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
//     return CustomScrollPhysics(
//       onScroll: onScroll,
//       parent: buildParent(ancestor),
//     );
//   }

//   @override
//   double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
//     onScroll(position.pixels);
//     return super.applyPhysicsToUserOffset(position, offset);
//   }
// }
