import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/model/postmodel.dart';
import 'package:btolet/view/post/property/widget/btn.dart';
import 'package:btolet/view/home/widget/btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortingProperty extends StatefulWidget {
  const SortingProperty({super.key});

  @override
  State<SortingProperty> createState() => _SortingPropertyState();
}

class _SortingPropertyState extends State<SortingProperty> {
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
  double startval1 = 1, endval1 = 100;
  String priceText = "Any Price";
  sliderText(startval1, endval1) {
    setState(() {
      if (startval1 == 1 && endval1 == 100) {
        priceText = "Any Price";
      } else if (endval1 == 100) {
        priceText = '৳ ${startval1.toInt()} to ${endval1.toInt()} LAKH+';
      } else {
        priceText = '৳ ${startval1.toInt()} to ${endval1.toInt()} LAKH';
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
                    step: const FlutterSliderStep(step: 1),
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
                    max: 100,
                    min: 1,
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      setState(() {
                        startval1 = lowerValue;
                        endval1 = upperValue;
                        sliderText(startval1, endval1);

                        // postController.pmin.value = startval1.toInt();
                        // postController.pmax.value = endval1.toInt();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Type *',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  const PorpertyChipsSort(),
                  const SizedBox(height: 20),
                  const Text('I am Looking For'),
                  SelectableChipsTypeSort(
                    categorylist: type,
                  ),

                  SelectableChips(
                    categorylist: prooms,
                    catagoryName: 'Beds',
                    icon: Icons.bed_outlined,
                  ),
                  SelectableChips(
                    categorylist: prooms,
                    catagoryName: 'Baths',
                    icon: Icons.bathtub_outlined,
                  ),
                  SelectableChips(
                    categorylist: prooms,
                    catagoryName: 'Kitchens',
                    icon: Icons.kitchen_outlined,
                  ),
                  SelectableChips(
                    categorylist: prooms,
                    catagoryName: 'Dining',
                    icon: Icons.self_improvement_sharp,
                  ),
                  // SelectableChips(
                  //   categorylist: prooms,
                  //   catagoryName: 'Balcony',
                  //   icon: Icons.balcony_rounded,
                  // ),
                  const SizedBox(height: 20),
                  const Text(
                    'Aminities(op)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 10,
                          children: [
                            CustomeChipPorperty(
                              text: "Balcony",
                              icon: Icons.balcony_rounded,
                            ),
                            CustomeChipPorperty(
                              text: "Parking",
                              icon: Icons.directions_bike,
                            ),
                            CustomeChipPorperty(
                              text: "CCTV",
                              icon: Icons.photo_camera,
                            ),
                            CustomeChipPorperty(
                              text: "GAS",
                              icon: Icons.local_fire_department_outlined,
                            ),
                            CustomeChipPorperty(
                              text: "Elevator",
                              icon: Icons.elevator_outlined,
                            ),
                            CustomeChipPorperty(
                              text: "Security Guard",
                              icon: Icons.security_rounded,
                            ),
                            CustomeChipPorperty(
                              text: "Power Backup",
                              icon: Icons.power_settings_new_rounded,
                            ),
                            CustomeChipPorperty(
                              text: "Fire Alarm",
                              icon: Icons.fire_extinguisher,
                            ),
                            CustomeChipPorperty(
                              text: "Gaser",
                              icon: Icons.gas_meter_outlined,
                            ),
                            CustomeChipPorperty(
                              text: "Wasa Connection",
                              icon: Icons.gas_meter_outlined,
                            ),
                            CustomeChipPorperty(
                              text: "Fire exit",
                              icon: Icons.gas_meter_outlined,
                            ),
                            CustomeChipPorperty(
                              text: "West Disposal",
                              icon: Icons.gas_meter_outlined,
                            ),
                            CustomeChipPorperty(
                              text: "Garden",
                              icon: Icons.gas_meter_outlined,
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
        case "Gaser":
          return postController.gaser.value;
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
            case "Gaser":
              postController.gaser.value = !postController.gaser.value;
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
  final String catagory;
  const CatagoryCpx({
    super.key,
    required this.catagory,
  });

  @override
  State<CatagoryCpx> createState() => _CatagoryCpxState();
}

class _CatagoryCpxState extends State<CatagoryCpx> {
  final PostController postController = Get.find();

  getController() {
    if (widget.catagory == 'Family') {
      return postController.family.value;
    } else if (widget.catagory == 'Bachelor') {
      return postController.bachelor.value;
    } else if (widget.catagory == 'Office') {
      return postController.office.value;
    } else if (widget.catagory == 'Male Sit') {
      return postController.sitMale.value;
    } else if (widget.catagory == 'Female Sit') {
      return postController.sitFemale.value;
    } else if (widget.catagory == 'Sub-let') {
      return postController.sublet.value;
    } else if (widget.catagory == 'Hostel') {
      return postController.hostel.value;
    } else if (widget.catagory == 'Shop') {
      return postController.shop.value;
    } else if (widget.catagory == 'Only Garage') {
      return postController.onlygarage.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return FilterChip(
          showCheckmark: false,
          label: Text(
            widget.catagory,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          selected: getController(),
          onSelected: (value) {
            if (widget.catagory == 'Family') {
              postController.family.value = !postController.family.value;
            } else if (widget.catagory == 'Bachelor') {
              postController.bachelor.value = !postController.bachelor.value;
            } else if (widget.catagory == 'Office') {
              postController.office.value = !postController.office.value;
            } else if (widget.catagory == 'Male Sit') {
              postController.sitMale.value = !postController.sitMale.value;
            } else if (widget.catagory == 'Female Sit') {
              postController.sitFemale.value = !postController.sitFemale.value;
            } else if (widget.catagory == 'Sub-let') {
              postController.sublet.value = !postController.sublet.value;
            } else if (widget.catagory == 'Hostel') {
              postController.hostel.value = !postController.hostel.value;
            } else if (widget.catagory == 'Shop') {
              postController.shop.value = !postController.shop.value;
            } else if (widget.catagory == 'Only Garage') {
              postController.onlygarage.value =
                  !postController.onlygarage.value;
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

//*---------------------
class PorpertyChipsSort extends StatefulWidget {
  const PorpertyChipsSort({
    super.key,
  });

  @override
  State<PorpertyChipsSort> createState() => _PorpertyChipsSortState();
}

class _PorpertyChipsSortState extends State<PorpertyChipsSort> {
  PostController postController = Get.find();
  int selectedChoiceIndex = 0;

  List<Widget> _buildChoiceChips() {
    return postController.category.map((String option) {
      return ChoiceChip(
        label: Text(option),
        selected:
            selectedChoiceIndex == postController.category.indexOf(option),
        onSelected: (bool selected) {
          setState(() {
            selectedChoiceIndex =
                selected ? postController.category.indexOf(option) : -1;
            // print('Selected Choice: ${options[selectedChoiceIndex]}');
            if (selectedChoiceIndex == 0 || selectedChoiceIndex == 1) {
              postController.iscategory.value = true;
            } else {
              postController.iscategory.value = false;
            }

            print('$selectedChoiceIndex');
          });
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Center(
            child: Wrap(
              spacing: 8.0,
              children: _buildChoiceChips(),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectableChips extends StatefulWidget {
  final List categorylist;
  final String catagoryName;
  final IconData icon;
  const SelectableChips({
    super.key,
    required this.categorylist,
    required this.catagoryName,
    required this.icon,
  });

  @override
  State<SelectableChips> createState() => _SelectableChipsState();
}

class _SelectableChipsState extends State<SelectableChips> {
  int selectedChoiceIndex = 0;

  _buildChoiceChips() {
    return widget.categorylist.map<Widget>((dynamic option) {
      return ChoiceChip(
        label: Text(option),
        selected: selectedChoiceIndex == widget.categorylist.indexOf(option),
        onSelected: (bool selected) {
          setState(() {
            selectedChoiceIndex =
                selected ? widget.categorylist.indexOf(option) : -1;
          });
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              Icon(
                widget.icon,
                color: Colors.black45,
              ),
              const SizedBox(width: 10),
              Text(
                widget.catagoryName,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8.0,
            children: _buildChoiceChips(),
          ),
        ],
      ),
    );
  }
}
