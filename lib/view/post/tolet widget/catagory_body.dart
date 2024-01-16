import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:btolet/view/post/tolet%20widget/chips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import 'dropdown.dart';
import 'text_input.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({super.key});

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  double space = 20.0;
  final ToletController toletController = Get.find();
  DateTime? _chosenDateTime;

  void _showDatePicker(ctx) {
    var now = DateTime.now();
    DateTime minDate = DateTime(now.year, now.month);
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                      initialDateTime: now,
                      minimumDate: minDate,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (val) {
                        print(val);
                        toletController.rentFrom = val;
                        setState(() {
                          _chosenDateTime = val;
                          toletController.rentFrom = val;
                        });
                      },
                    ),
                  ),
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (toletController.categories['Only Garage']!.value) {
          return Column(
            children: [
              SizedBox(height: space),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rent From',
                          style: TextStyle(
                            letterSpacing: 0.7,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 46,
                          width: Get.width / 2.35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF2F3F5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              _showDatePicker(context);
                            },
                            child: _chosenDateTime == null
                                ? Text(
                                    DateFormat()
                                        .add_MMMd()
                                        .format(DateTime.now()),
                                  )
                                : Text(
                                    DateFormat()
                                        .add_MMMd()
                                        .format(_chosenDateTime!),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    const DropDown(
                      title: "Type *",
                      category: Category.garage,
                      widthh: 2.35,
                      topPadding: 0,
                    ),
                  ],
                ),
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
                widthh: 1.2,
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
                  DropDown(
                    title: "Bed room *",
                    category: Category.bedrooms,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                  DropDown(
                    title: "Bath room*",
                    category: Category.bathrooms,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                ],
              ),
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropDown(
                    title: "Dining",
                    category: Category.dining,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                  DropDown(
                    title: "Kitchne",
                    category: Category.kitchen,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                ],
              ),
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropDown(
                    title: "Floor No",
                    category: Category.floorno,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                  DropDown(
                    title: "Facing",
                    category: Category.facing,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                ],
              ),
              SizedBox(height: space),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInput(
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
                      widthh: 2.35, svgicon: '',
                      focusNode: toletController.roomSizefocusNode,
                    ),
                    SizedBox(width: space),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rent From',
                          style: TextStyle(
                            letterSpacing: 0.7,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 46,
                          width: Get.width / 2.35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF2F3F5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              _showDatePicker(context);
                            },
                            child: _chosenDateTime == null
                                ? Text(
                                    DateFormat()
                                        .add_MMMd()
                                        .format(DateTime.now()),
                                  )
                                : Text(
                                    DateFormat()
                                        .add_MMMd()
                                        .format(_chosenDateTime!),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: space),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInput(
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
                      widthh: 2.35,
                      svgicon: '',
                      focusNode: toletController.maintenancefocusNode,
                    ),
                    SizedBox(width: space),
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
                      widthh: 2.35,
                      svgicon: '',
                      focusNode: toletController.rentfocusNode,
                    ),
                  ],
                ),
              ),
              SizedBox(height: space),
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
              SizedBox(height: space),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 10,
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
                  DropDown(
                    title: "Room *",
                    category: Category.bedrooms,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                  DropDown(
                    title: "Bathroom *",
                    category: Category.bathrooms,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                ],
              ),
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropDown(
                    title: "Floor No",
                    category: Category.floorno,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                  DropDown(
                    title: "Facing",
                    category: Category.facing,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                ],
              ),
              SizedBox(height: space),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInput(
                      topPadding: 0,
                      title: "Room Size",
                      textType: TextInputType.text,
                      hintText: "12x12 or ft\u00b2",
                      titlelenth: 500,
                      suffixtext: "",
                      controller: toletController.roomSize,
                      iconh: 23,
                      iconw: 23,
                      widthh: 2.35,
                      svgicon: '',
                      focusNode: toletController.roomSizefocusNode,
                    ),
                    SizedBox(width: space),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rent From',
                          style: TextStyle(
                            letterSpacing: 0.7,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 46,
                          width: Get.width / 2.35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF2F3F5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              _showDatePicker(context);
                            },
                            child: _chosenDateTime == null
                                ? Text(
                                    DateFormat()
                                        .add_MMMd()
                                        .format(DateTime.now()),
                                  )
                                : Text(
                                    DateFormat()
                                        .add_MMMd()
                                        .format(_chosenDateTime!),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: space),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInput(
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
                      widthh: 2.35,
                      svgicon: '',
                      focusNode: toletController.maintenancefocusNode,
                    ),
                    SizedBox(width: space),
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
                      widthh: 2.35,
                      svgicon: '',
                      focusNode: toletController.rentfocusNode,
                    ),
                  ],
                ),
              ),
              SizedBox(height: space),
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
              SizedBox(height: space),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 10,
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
            ],
          );
        } else if (toletController.categories['Shop']!.value) {
          return Column(
            children: [
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropDown(
                    title: "Floor No *",
                    category: Category.floorno,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                  DropDown(
                    title: "Facing",
                    category: Category.facing,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                ],
              ),
              SizedBox(height: space),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInput(
                      topPadding: 0,
                      title: "Room Size",
                      textType: TextInputType.text,
                      hintText: "12x12 or ft\u00b2",
                      titlelenth: 500,
                      suffixtext: "",
                      controller: toletController.roomSize,
                      iconh: 23,
                      iconw: 23,
                      widthh: 2.35,
                      svgicon: '',
                      focusNode: toletController.roomSizefocusNode,
                    ),
                    SizedBox(width: space),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rent From',
                          style: TextStyle(
                            letterSpacing: 0.7,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 46,
                          width: Get.width / 2.35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF2F3F5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              _showDatePicker(context);
                            },
                            child: _chosenDateTime == null
                                ? Text(
                                    DateFormat()
                                        .add_MMMd()
                                        .format(DateTime.now()),
                                  )
                                : Text(
                                    DateFormat()
                                        .add_MMMd()
                                        .format(_chosenDateTime!),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                widthh: 1.2,
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
                  DropDown(
                    title: "Bedroom *",
                    category: Category.bedrooms,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                  DropDown(
                    title: "Bathroom *",
                    category: Category.bathrooms,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                ],
              ),
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropDown(
                    title: "Dining",
                    category: Category.dining,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                  DropDown(
                    title: "Kitchne *",
                    category: Category.kitchen,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                ],
              ),
              SizedBox(height: space),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropDown(
                    title: "Floor No",
                    category: Category.floorno,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                  DropDown(
                    title: "Facing",
                    category: Category.facing,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                ],
              ),
              SizedBox(height: space),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInput(
                      topPadding: 0,
                      title: "Room Size",
                      textType: TextInputType.text,
                      hintText: "12x12 or ft\u00b2",
                      titlelenth: 500,
                      suffixtext: "ft\u00b2",
                      controller: toletController.roomSize,
                      iconh: 23,
                      iconw: 23,
                      widthh: 2.35,
                      svgicon: '',
                      focusNode: toletController.roomSizefocusNode,
                    ),
                    SizedBox(width: space),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rent From',
                          style: TextStyle(
                            letterSpacing: 0.7,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 46,
                          width: Get.width / 2.35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF2F3F5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              _showDatePicker(context);
                            },
                            child: _chosenDateTime == null
                                ? Text(
                                    DateFormat()
                                        .add_MMMd()
                                        .format(DateTime.now()),
                                  )
                                : Text(
                                    DateFormat()
                                        .add_MMMd()
                                        .format(_chosenDateTime!),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: space),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInput(
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
                      widthh: 2.35,
                      svgicon: '',
                      focusNode: toletController.maintenancefocusNode,
                    ),
                    SizedBox(width: space),
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
                      widthh: 2.35,
                      svgicon: '',
                      focusNode: toletController.rentfocusNode,
                    ),
                  ],
                ),
              ),
              SizedBox(height: space),
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
              SizedBox(height: space),
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
            ],
          );
        }
      },
    );
  }
}
