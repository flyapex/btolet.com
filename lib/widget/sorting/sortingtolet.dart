import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:btolet/controller/post_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class SortingTolet extends StatefulWidget {
  const SortingTolet({super.key});

  @override
  State<SortingTolet> createState() => _SortingToletState();
}

class _SortingToletState extends State<SortingTolet> {
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
        priceText = '৳ ${startval1.toInt()} to ${endval1.toInt()}+/month';
      } else {
        priceText = '৳ ${startval1.toInt()} to ${endval1.toInt()}/month';
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
                  Container(
                    color: Colors.white,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => {},
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xffEEEEEE),
                                      child: SvgPicture.asset(
                                        'assets/icons/location.svg',
                                        height: 18,
                                        width: 18,
                                        // ignore: deprecated_member_use
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: Get.width / 1.5,
                                      child: const Text(
                                        "Nirala,Khulna,Khulna Division .....",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          letterSpacing: 0.1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: SvgPicture.asset(
                                    'assets/icons/arrow.svg',
                                    height: 12,
                                    width: 12,
                                    // ignore: deprecated_member_use
                                    color: const Color(0xffAFAFAF),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                      });
                    },
                  ),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(microseconds: 500),
                          width: Get.width,
                          height: categorySize,
                          child: ShaderMask(
                            shaderCallback: (Rect rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.purple,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.purple
                                ],
                                stops: [
                                  0.0,
                                  0.1,
                                  0.9,
                                  1.0
                                ], // 10% purple, 80% transparent, 10% purple
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstOut,
                            // child: const Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Expanded(
                            //       child: Wrap(
                            //         spacing: 10,
                            //         children: [
                            //           CatagoryCpx(catagory: 1),
                            //           CatagoryCpx(catagory: 2),
                            //           CatagoryCpx(catagory: 4),
                            //           CatagoryCpx(catagory: 5),
                            //           CatagoryCpx(catagory: 6),
                            //           CatagoryCpx(catagory: 7),
                            //           CatagoryCpx(catagory: 8),
                            //           CatagoryCpx(catagory: 9),
                            //           CatagoryCpx(catagory: 3),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            child: ListView(
                              // scrollDirection: Axis.horizontal,
                              children: const [
                                Wrap(
                                  spacing: 10,
                                  children: [
                                    CatagoryCpx(catagory: 1),
                                    CatagoryCpx(catagory: 2),
                                    CatagoryCpx(catagory: 4),
                                    CatagoryCpx(catagory: 5),
                                    CatagoryCpx(catagory: 6),
                                    CatagoryCpx(catagory: 7),
                                    CatagoryCpx(catagory: 8),
                                    CatagoryCpx(catagory: 9),
                                    CatagoryCpx(catagory: 3),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              print(categorySize);
                              categorySize = (categorySize == 117) ? 170 : 117;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 45,
                            padding: const EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        categorySize == 117
                                            ? 'See more'
                                            : 'Close',
                                        style: const TextStyle(
                                          color: Color(0xff083437),
                                        ),
                                      ),
                                      const Icon(
                                        Feather.chevron_down,
                                        color: Color(0xff083437),
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Expanded(
                  //       child: Wrap(
                  //         spacing: 10,
                  //         children: [
                  //           CatagoryCpx(catagory: 1),
                  //           CatagoryCpx(catagory: 2),
                  //           CatagoryCpx(catagory: 4),
                  //           CatagoryCpx(catagory: 5),
                  //           CatagoryCpx(catagory: 6),
                  //           CatagoryCpx(catagory: 7),
                  //           CatagoryCpx(catagory: 8),
                  //           CatagoryCpx(catagory: 9),
                  //           CatagoryCpx(catagory: 3),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       CatagoryCpx(catagory: 1),
                  //       SizedBox(width: 10),
                  //       CatagoryCpx(catagory: 2),
                  //       SizedBox(width: 10),
                  //       CatagoryCpx(catagory: 3),
                  //       SizedBox(width: 10),
                  //     ],
                  //   ),
                  // ),
                  // const SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       CatagoryCpx(catagory: 4),
                  //       SizedBox(width: 10),
                  //       CatagoryCpx(catagory: 5),
                  //       SizedBox(width: 10),
                  //       CatagoryCpx(catagory: 6),
                  //       SizedBox(width: 10),
                  //     ],
                  //   ),
                  // ),
                  // const SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       CatagoryCpx(catagory: 7),
                  //       SizedBox(width: 10),
                  //       CatagoryCpx(catagory: 8),
                  //       SizedBox(width: 10),
                  //       CatagoryCpx(catagory: 9),
                  //       SizedBox(width: 10),
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
                  const Rowbtn(),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(Icons.shower_outlined),
                      SizedBox(width: 10),
                      Text('Bathroom'),
                    ],
                  ),

                  const SizedBox(height: 20),
                  // ignore: prefer_const_constructors
                  Rowbtn(),
                  const SizedBox(height: 20),
                  const Text('Fasalitis'),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 10,
                          children: [
                            CustomeChip(
                              text: "Balcony",
                              icon: Icons.balcony_rounded,
                            ),
                            CustomeChip(
                              text: "Parking",
                              icon: Icons.directions_bike,
                            ),
                            CustomeChip(
                              text: "CCTV",
                              icon: Icons.photo_camera,
                            ),
                            CustomeChip(
                              text: "GAS",
                              icon: Icons.local_fire_department_outlined,
                            ),
                            CustomeChip(
                              text: "Lift",
                              icon: Icons.elevator_outlined,
                            ),
                            CustomeChip(
                              text: "Security Guard",
                              icon: Icons.security_rounded,
                            ),
                            CustomeChip(
                              text: "WIFI",
                              icon: Icons.wifi_rounded,
                            ),
                            CustomeChip(
                              text: "Power Backup",
                              icon: Icons.power_settings_new_rounded,
                            ),
                            CustomeChip(
                              text: "Fire Alarm",
                              icon: Icons.fire_extinguisher,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Show 123,23 Property',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomeChip extends StatelessWidget {
  final String text;

  final IconData icon;
  const CustomeChip({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find();
    getController() {
      switch (text) {
        case "Balcony":
          return postController.balcony.value;
        case "Parking":
          return postController.parking.value;
        case "CCTV":
          return postController.cctv.value;
        case "GAS":
          return postController.gas.value;
        case "Lift":
          return postController.lift.value;
        case "Security Guard":
          return postController.security.value;
        case "WIFI":
          return postController.wifi.value;
        case "Power Backup":
          return postController.powerbackup.value;
        case "Fire Alarm":
          return postController.firealarm.value;
        default:
          return false;
      }
    }

    return Obx(
      () => FilterChip(
        showCheckmark: false,
        label: Text(text),
        selected: getController(),
        onSelected: (value) {
          // postController.lift.value = !postController.lift.value;
          switch (text) {
            case "Balcony":
              postController.balcony.value = !postController.balcony.value;
              break;
            case "Parking":
              postController.parking.value = !postController.parking.value;
              break;
            case "CCTV":
              postController.cctv.value = !postController.cctv.value;
              break;
            case "GAS":
              postController.gas.value = !postController.gas.value;
              break;
            case "Lift":
              postController.lift.value = !postController.lift.value;
              break;
            case "Security Guard":
              postController.security.value = !postController.security.value;
              break;
            case "WIFI":
              postController.wifi.value = !postController.wifi.value;
              break;
            case "Power Backup":
              postController.powerbackup.value =
                  !postController.powerbackup.value;
              break;
            case "Fire Alarm":
              postController.firealarm.value = !postController.firealarm.value;
              break;
            default:
              break;
          }
        },
        avatar: Icon(
          icon,
          // getController() ? Icons.check : icon,
          color: getController()
              ? const Color(0xff0166EE)
              : const Color.fromARGB(255, 192, 194, 198),
          // color: getController()
          //     ? const Color(0xff0166EE)
          //     : const Color.fromARGB(255, 192, 194, 198),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        side: BorderSide(
          color: getController()
              ? const Color(0xff0166EE)
              : Colors.black.withOpacity(0.1),
        ),
        elevation: 0.3,
        selectedShadowColor: Colors.black.withOpacity(0.5),
        shadowColor: Colors.black.withOpacity(0.5),
        backgroundColor: Colors.white,
        selectedColor: Colors.white,
      ),
    );
  }
}

class Rowbtn extends StatefulWidget {
  const Rowbtn({super.key});

  @override
  State<Rowbtn> createState() => _RowbtnState();
}

class _RowbtnState extends State<Rowbtn> {
  List<String> categories = ['1', '2', '3', '4', '5', '6+'];
  List<bool> isSelected = [false, false, false, false, true, true];
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.black,
      ),
      child: SizedBox(
        height: 40,
        width: Get.width,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return FilterChip(
              showCheckmark: false,
              // padding: const EdgeInsets.only(left: 5, right: 5),
              labelPadding: const EdgeInsets.only(right: 5, left: 5),
              label: Text(
                categories[index],
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              selected: isSelected[index],
              onSelected: (bool selected) {
                setState(() {
                  isSelected[index] = selected;
                });
              },
              avatar: Icon(
                isSelected[index] ? Icons.check_circle_rounded : Icons.add,
                color: isSelected[index]
                    ? const Color(0xff0166EE)
                    : const Color.fromARGB(255, 192, 194, 198),
              ),
              elevation: 0.3,
              side: BorderSide(
                color: isSelected[index]
                    ? const Color(0xff0166EE)
                    : Colors.black.withOpacity(0.1),
              ),
              selectedShadowColor: Colors.black.withOpacity(0.5),
              shadowColor: Colors.black.withOpacity(0.5),
              backgroundColor: Colors.white,
              selectedColor: Colors.white,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 10);
          },
        ),
      ),
    );
  }
}

class CatagoryCpx extends StatefulWidget {
  final int catagory;
  const CatagoryCpx({
    super.key,
    required this.catagory,
  });

  @override
  State<CatagoryCpx> createState() => _CatagoryCpxState();
}

class _CatagoryCpxState extends State<CatagoryCpx> {
  final PostController postController = Get.find();
  getText() {
    if (widget.catagory == 1) {
      return 'Family';
    } else if (widget.catagory == 2) {
      return 'Bachelor';
    } else if (widget.catagory == 3) {
      return 'Office Space';
    } else if (widget.catagory == 4) {
      return 'Male Sit';
    } else if (widget.catagory == 5) {
      return 'Female Sit';
    } else if (widget.catagory == 6) {
      return 'Sub-let ';
    } else if (widget.catagory == 7) {
      return 'Hostel';
    } else if (widget.catagory == 8) {
      return 'Shop';
    } else if (widget.catagory == 9) {
      return 'Garage';
    }
  }

  getController() {
    if (widget.catagory == 1) {
      return postController.family.value;
    } else if (widget.catagory == 2) {
      return postController.bachelor.value;
    } else if (widget.catagory == 3) {
      return postController.officeSpace.value;
    } else if (widget.catagory == 4) {
      return postController.sitMale.value;
    } else if (widget.catagory == 5) {
      return postController.sitFemale.value;
    } else if (widget.catagory == 6) {
      return postController.sublet.value;
    } else if (widget.catagory == 7) {
      return postController.hostel.value;
    } else if (widget.catagory == 8) {
      return postController.shop.value;
    } else if (widget.catagory == 9) {
      return postController.garage.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return FilterChip(
          showCheckmark: false,
          label: Text(
            getText(),
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          selected: getController(),
          onSelected: (value) {
            if (widget.catagory == 1) {
              postController.family.value = !postController.family.value;
            } else if (widget.catagory == 2) {
              postController.bachelor.value = !postController.bachelor.value;
            } else if (widget.catagory == 3) {
              postController.officeSpace.value =
                  !postController.officeSpace.value;
            } else if (widget.catagory == 4) {
              postController.sitMale.value = !postController.sitMale.value;
            } else if (widget.catagory == 5) {
              postController.sitFemale.value = !postController.sitFemale.value;
            } else if (widget.catagory == 6) {
              postController.sublet.value = !postController.sublet.value;
            } else if (widget.catagory == 7) {
              postController.hostel.value = !postController.hostel.value;
            } else if (widget.catagory == 8) {
              postController.shop.value = !postController.shop.value;
            } else if (widget.catagory == 9) {
              postController.garage.value = !postController.garage.value;
            }

            // postController.allCategoryCheck();
          },
          avatar: Icon(
            getController() ? Icons.check_circle_rounded : Icons.add,
            color: getController()
                ? const Color(0xff0166EE)
                : const Color.fromARGB(255, 192, 194, 198),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          side: BorderSide(
            color: getController()
                ? const Color(0xff0166EE)
                : Colors.black.withOpacity(0.1),
          ),
          elevation: 0.3,
          selectedShadowColor: Colors.black.withOpacity(0.5),
          shadowColor: Colors.black.withOpacity(0.5),
          backgroundColor: Colors.white,
          selectedColor: Colors.white,
        );
      },
    );
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  final Function(double) onScroll;

  const CustomScrollPhysics({required this.onScroll, ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(
      onScroll: onScroll,
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    onScroll(position.pixels);
    return super.applyPhysicsToUserOffset(position, offset);
  }
}
