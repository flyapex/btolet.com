import 'package:btolet/controller/tolet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import 'dropdown.dart';
import 'fasalitis.dart';
import 'text_input.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({super.key});

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  double space = 20.0;
  final ToletController toletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (toletController.categories['Only Garage']!.value) {
          return Column(
            children: [
              SizedBox(height: space),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 1,
                    child: DateTimeSelect(),
                  ),
                  SizedBox(width: space),
                  const Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Type *",
                      category: Category.garage,
                      topPadding: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              TextInput(
                topPadding: 0,
                title: "Garag  Rent*",
                textType: TextInputType.number,
                hintText: "3,000 ৳",
                titlelenth: 4,
                suffixtext: "৳",
                controller: toletController.rent,
                numberFormatter: ThousandsFormatter(),
                iconh: 23,
                iconw: 23,
                svgicon: '',
                focusNode: toletController.rentfocusNode,
              ),
            ],
          );
        } else if (toletController.categories['Office']!.value &&
            toletController.categories['Family']!.value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Bed room *",
                      category: Category.bedrooms,
                      topPadding: 0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Bath room*",
                      category: Category.bathrooms,
                      topPadding: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Dining",
                      category: Category.dining,
                      topPadding: 0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Kitchne",
                      category: Category.kitchen,
                      topPadding: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Floor No",
                      category: Category.floorno,
                      topPadding: 0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Facing",
                      category: Category.facing,
                      topPadding: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextInput(
                      topPadding: 0,
                      // title: "Room Size (ft\u00b2)",
                      title: "Room Size ",
                      textType: TextInputType.text,
                      hintText: "12x12 or ft\u00b2",
                      titlelenth: 500,
                      suffixtext: "",
                      controller: toletController.roomSize,
                      iconh: 23,
                      iconw: 23,
                      svgicon: '',
                      focusNode: toletController.roomSizefocusNode,
                    ),
                  ),
                  SizedBox(width: space),
                  const Expanded(
                    flex: 1,
                    child: DateTimeSelect(),
                  ),
                ],
              ),
              SizedBox(height: space),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextInput(
                      topPadding: 0,
                      title: "Maintenance(Monthly)",
                      textType: TextInputType.number,
                      hintText: "300",
                      titlelenth: 4,
                      suffixtext: "",
                      controller: toletController.maintenance,
                      numberFormatter: ThousandsFormatter(),
                      iconh: 23,
                      iconw: 23,
                      svgicon: '',
                      focusNode: toletController.maintenancefocusNode,
                    ),
                  ),
                  SizedBox(width: space),
                  Expanded(
                    flex: 1,
                    child: TextInput(
                      topPadding: 0,
                      title: "Rent *",
                      textType: TextInputType.number,
                      hintText: "20,000 ৳",
                      titlelenth: 500,
                      suffixtext: "৳",
                      controller: toletController.rent,
                      numberFormatter: ThousandsFormatter(),
                      iconh: 23,
                      iconw: 23,
                      svgicon: '',
                      focusNode: toletController.rentfocusNode,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              const Facilities(),
            ],
          );
        } else if (toletController.categories['Office']!.value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Room *",
                      category: Category.bedrooms,
                      topPadding: 0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Bathroom *",
                      category: Category.bathrooms,
                      topPadding: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Floor No",
                      category: Category.floorno,
                      topPadding: 0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Facing",
                      category: Category.facing,
                      topPadding: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextInput(
                      topPadding: 0,
                      title: "Room Size",
                      textType: TextInputType.text,
                      hintText: "12x12 or ft\u00b2",
                      titlelenth: 500,
                      suffixtext: "",
                      controller: toletController.roomSize,
                      iconh: 23,
                      iconw: 23,
                      svgicon: '',
                      focusNode: toletController.roomSizefocusNode,
                    ),
                  ),
                  SizedBox(width: space),
                  const Expanded(
                    flex: 1,
                    child: DateTimeSelect(),
                  ),
                ],
              ),
              SizedBox(height: space),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextInput(
                      topPadding: 0,
                      title: "Maintenance(Monthly)",
                      textType: TextInputType.number,
                      hintText: "300",
                      titlelenth: 4,
                      suffixtext: "",
                      controller: toletController.maintenance,
                      numberFormatter: ThousandsFormatter(),
                      iconh: 23,
                      iconw: 23,
                      svgicon: '',
                      focusNode: toletController.maintenancefocusNode,
                    ),
                  ),
                  SizedBox(width: space),
                  Expanded(
                    flex: 1,
                    child: TextInput(
                      topPadding: 0,
                      title: "Rent *",
                      textType: TextInputType.number,
                      hintText: "20,000 ৳",
                      titlelenth: 500,
                      suffixtext: "৳",
                      controller: toletController.rent,
                      numberFormatter: ThousandsFormatter(),
                      iconh: 23,
                      iconw: 23,
                      svgicon: '',
                      focusNode: toletController.rentfocusNode,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              const Facilities(),
            ],
          );
        } else if (toletController.categories['Shop']!.value) {
          return Column(
            children: [
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Floor No *",
                      category: Category.floorno,
                      topPadding: 0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropDown(
                      title: "Facing",
                      category: Category.facing,
                      topPadding: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextInput(
                      topPadding: 0,
                      title: "Room Size",
                      textType: TextInputType.text,
                      hintText: "12x12 or ft\u00b2",
                      titlelenth: 500,
                      suffixtext: "",
                      controller: toletController.roomSize,
                      iconh: 23,
                      iconw: 23,
                      svgicon: '',
                      focusNode: toletController.roomSizefocusNode,
                    ),
                  ),
                  SizedBox(width: space),
                  const Expanded(
                    flex: 1,
                    child: DateTimeSelect(),
                  ),
                ],
              ),
              SizedBox(height: space),
              TextInput(
                topPadding: 0,
                title: "Rent *",
                textType: TextInputType.number,
                hintText: "20,000 ৳",
                titlelenth: 500,
                suffixtext: "৳",
                controller: toletController.rent,
                numberFormatter: ThousandsFormatter(),
                iconh: 23,
                iconw: 23,
                svgicon: '',
                focusNode: toletController.rentfocusNode,
              ),
            ],
          );
        } else {
          return Column(
            children: [
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Bedroom *",
                      category: Category.bedrooms,
                      topPadding: 0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropDown(
                      title: "Bathroom *",
                      category: Category.bathrooms,
                      topPadding: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Dining",
                      category: Category.dining,
                      topPadding: 0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Kitchne *",
                      category: Category.kitchen,
                      topPadding: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Floor No",
                      category: Category.floorno,
                      topPadding: 0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: DropDown(
                      title: "Facing",
                      category: Category.facing,
                      topPadding: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextInput(
                      topPadding: 0,
                      title: "Room Size",
                      textType: TextInputType.text,
                      hintText: "12x12 or ft\u00b2",
                      titlelenth: 500,
                      suffixtext: "ft\u00b2",
                      controller: toletController.roomSize,
                      iconh: 23,
                      iconw: 23,
                      svgicon: '',
                      focusNode: toletController.roomSizefocusNode,
                    ),
                  ),
                  SizedBox(width: space),
                  const Expanded(
                    flex: 1,
                    child: DateTimeSelect(),
                  ),
                ],
              ),
              SizedBox(height: space),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextInput(
                      topPadding: 0,
                      title: "Maintenance(Monthly)",
                      textType: TextInputType.number,
                      hintText: "300",
                      titlelenth: 4,
                      suffixtext: "",
                      controller: toletController.maintenance,
                      numberFormatter: ThousandsFormatter(),
                      iconh: 23,
                      iconw: 23,
                      svgicon: '',
                      focusNode: toletController.maintenancefocusNode,
                    ),
                  ),
                  SizedBox(width: space),
                  Expanded(
                    flex: 1,
                    child: TextInput(
                      topPadding: 0,
                      title: "Rent *",
                      textType: TextInputType.number,
                      hintText: "20,000 ৳",
                      titlelenth: 500,
                      suffixtext: "৳",
                      controller: toletController.rent,
                      numberFormatter: ThousandsFormatter(),
                      iconh: 23,
                      iconw: 23,
                      svgicon: '',
                      focusNode: toletController.rentfocusNode,
                    ),
                  ),
                ],
              ),
              SizedBox(height: space),
              const Facilities(),
            ],
          );
        }
      },
    );
  }
}
