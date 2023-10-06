import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/model/postmodel.dart';
import 'package:btolet/widget/imagepicker.dart';
import 'package:btolet/widget/sorting/sortingtolet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../btn.dart';

class PostPage1 extends StatefulWidget {
  const PostPage1({super.key});

  @override
  State<PostPage1> createState() => _PostPage1State();
}

class _PostPage1State extends State<PostPage1> {
  final PostController postController = Get.find();
  double space = 20.0;
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
                        setState(() {
                          _chosenDateTime = val;
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
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
          ? const SizedBox()
          : SizedBox(
              width: 140,
              height: 45,
              child: FloatingActionButton.extended(
                foregroundColor: const Color(0xff5E72E4),
                shape: RoundedRectangleBorder(
                    // side: const BorderSide(width: 3, color: Colors.red),
                    borderRadius: BorderRadius.circular(100)),
                elevation: 0,
                onPressed: () async {
                  postController.pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                ),
                label: const Text(
                  "NEXT",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallTextBox(
                  topPadding: 0,
                  title: "Property Name",
                  textType: TextInputType.text,
                  hintText: "Masud Monjil",
                  titlelenth: 500,
                  suffixtext: "",
                  controller: postController.propertyName,
                  iconh: 23,
                  iconw: 23,
                  widthh: 2.35 / 2,
                ),

                SizedBox(height: space),
                Text(
                  'Category *',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 10,
                        children: [
                          CatagoryCpx(catagory: 'Family'),
                          CatagoryCpx(catagory: 'Bachelor'),
                          CatagoryCpx(catagory: 'Male Sit'),
                          CatagoryCpx(catagory: 'Female Sit'),
                          CatagoryCpx(catagory: 'Sub-let'),
                          CatagoryCpx(catagory: 'Hostel'),
                          CatagoryCpx(catagory: 'Shop'),
                          CatagoryCpx(catagory: 'Office'),
                          CatagoryCpx(catagory: 'Only Garage'),
                        ],
                      ),
                    ),
                  ],
                ),
                postController.onlygarage.value
                    ? const SizedBox()
                    : SizedBox(height: space),
                postController.onlygarage.value
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DragdownBoxSmall(
                            title: "Bedroom *",
                            catagoryName: rooms,
                            widthh: 2.35,
                            topPadding: 0,
                          ),
                          DragdownBoxSmall(
                            title: "Bathroom",
                            catagoryName: bath,
                            widthh: 2.35,
                            topPadding: 0,
                          ),
                        ],
                      ),
                postController.onlygarage.value
                    ? const SizedBox()
                    : SizedBox(height: space),
                postController.onlygarage.value
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DragdownBoxSmall(
                            title: "Dining",
                            catagoryName: floors,
                            widthh: 2.35,
                            topPadding: 0,
                          ),
                          DragdownBoxSmall(
                            title: "Kitchne",
                            catagoryName: kitchen,
                            widthh: 2.35,
                            topPadding: 0,
                          ),
                        ],
                      ),
                postController.onlygarage.value
                    ? const SizedBox()
                    : SizedBox(height: space),
                postController.onlygarage.value
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DragdownBoxSmall(
                            title: "Floor No",
                            catagoryName: floors,
                            widthh: 2.35,
                            topPadding: 0,
                          ),
                          DragdownBoxSmall(
                            title: "Facing",
                            catagoryName: kitchen,
                            widthh: 2.35,
                            topPadding: 0,
                          ),
                        ],
                      ),

                postController.onlygarage.value
                    ? const SizedBox()
                    : SizedBox(height: space),
                postController.onlygarage.value
                    ? SizedBox(height: space)
                    : const SizedBox(),
                postController.onlygarage.value
                    ? SingleChildScrollView(
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
                            SmallTextBox(
                              topPadding: 0,
                              title: "Garag  Rent*",
                              textType: TextInputType.number,
                              hintText: "3,000 ৳",
                              titlelenth: 4,
                              suffixtext: "",
                              controller: postController.garagetxtcontroller,
                              iconh: 23,
                              iconw: 23,
                              widthh: 2.35,
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallTextBox(
                              topPadding: 0,
                              title: "Room Size (ft\u00b2)",
                              textType: TextInputType.number,
                              hintText: "230 ",
                              titlelenth: 500,
                              suffixtext: "৳",
                              controller: postController.squireft,
                              iconh: 23,
                              iconw: 23,
                              widthh: 2.35,
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
                postController.onlygarage.value
                    ? const SizedBox()
                    : SizedBox(height: space),
                postController.onlygarage.value
                    ? const SizedBox()
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallTextBox(
                              topPadding: 0,
                              title: "Maintenance(Monthly) *",
                              textType: TextInputType.number,
                              hintText: "300",
                              titlelenth: 4,
                              suffixtext: "",
                              controller: postController.maintenance,
                              iconh: 23,
                              iconw: 23,
                              widthh: 2.35,
                            ),
                            SizedBox(width: space),
                            SmallTextBox(
                              topPadding: 0,
                              title: "Rent *",
                              textType: TextInputType.number,
                              hintText: "20,000 ৳",
                              titlelenth: 500,
                              suffixtext: "৳",
                              controller: postController.price,
                              iconh: 23,
                              iconw: 23,
                              widthh: 2.35,
                            ),
                          ],
                        ),
                      ),
                postController.onlygarage.value
                    ? const SizedBox()
                    : SizedBox(height: space),
                postController.onlygarage.value
                    ? const SizedBox()
                    : const Text(
                        'Fasalitis(op)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                postController.onlygarage.value
                    ? const SizedBox()
                    : SizedBox(height: space),
                postController.onlygarage.value
                    ? const SizedBox()
                    : const Row(
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
                                CustomeChip(
                                  text: "Gaser",
                                  icon: Icons.gas_meter_outlined,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                SizedBox(height: space),
                const Text(
                  'Select image *',
                  style: TextStyle(
                    color: Color(0xff7B7B7B),
                    letterSpacing: 0.7,
                  ),
                ),
                const SizedBox(height: 10),
                // TextButton(
                //   onPressed: () {
                //     Get.bottomSheet(
                //       const OpenCameraPotion(),
                //       elevation: 20.0,
                //       enableDrag: true,
                //       backgroundColor: Colors.white,
                //       isScrollControlled: true,
                //       ignoreSafeArea: true,
                //       shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(20.0),
                //           topRight: Radius.circular(20.0),
                //         ),
                //       ),
                //       enterBottomSheetDuration: const Duration(milliseconds: 170),
                //     );
                //   },
                //   child: const Text(
                //     'Open',
                //     style: TextStyle(
                //       fontSize: 18,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
                const SelectImage(
                  icon: Feather.camera,
                  imagnumber: 1,
                ),
                SizedBox(height: space),
                DescriptionTextBox(
                  title: "Description *",
                  textType: TextInputType.text,
                  hintText:
                      "\nSpecify house condition, extra features and house etc👀",
                  controller: postController.description,
                  icon: Feather.file_text,
                ),
                const SizedBox(height: 30),
                // MaterialButton(
                //   minWidth: double.maxFinite,
                //   height: 45,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(22.0),
                //   ),
                //   elevation: 10.0,
                //   color: const Color(0xff5E72E4),
                //   onPressed: () {
                //     postController.pageController.nextPage(
                //       duration: const Duration(milliseconds: 400),
                //       curve: Curves.easeInOut,
                //     );
                //   },
                //   child: const Text(
                //     'Next',
                //     style: TextStyle(
                //       fontSize: 18,
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       letterSpacing: 1,
                //     ),
                //   ),
                // ),
                SizedBox(height: space),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
