import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/pages/post/tolet/widget/textbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'widget/chips.dart';
import 'widget/drapdown.dart';
import 'widget/imagepicker.dart';

class ToletPostPage1 extends StatefulWidget {
  const ToletPostPage1({super.key});

  @override
  State<ToletPostPage1> createState() => _ToletPostPage1State();
}

class _ToletPostPage1State extends State<ToletPostPage1> {
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
                        print(val);
                        postController.rentFrom = val;
                        setState(() {
                          _chosenDateTime = val;
                          // postController.rentFrom = val;
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
  void initState() {
    postController.rentFrom = DateTime.now();
    super.initState();
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
                TextInputBoxOnly(
                  topPadding: 0,
                  title: "Property Name",
                  textType: TextInputType.text,
                  hintText: "Masud Monjil",
                  titlelenth: 500,
                  suffixtext: "",
                  controller: postController.propertyNameTolet,
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
                // IconButton(
                //   onPressed: () {
                //     postController.getSelectedCategoryName();
                //     // postController.isGarage();
                //   },
                //   icon: const Icon(Icons.check_box),
                // ),
                const SizedBox(height: 10),
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
                          return CategoryToletChip(
                            category: category,
                            categoryState: categoryState,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                getCategory(),

                // postController.categories['Only Garage']!.value

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
                const SelectImageTolet(
                  icon: Feather.camera,
                  imagnumber: 12,
                ),
                SizedBox(height: space),
                DescriptionTextBox(
                  title: "Description *",
                  textType: TextInputType.text,
                  hintText:
                      "\nSpecify house condition, extra features and house etc👀",
                  controller: postController.discriptionTolet,
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

  getCategory() {
    if (postController.categories['Only Garage']!.value) {
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
                                DateFormat().add_MMMd().format(DateTime.now()),
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
                const DropDownBtn(
                  title: "Type *",
                  category: Category.garage,
                  widthh: 2.35,
                  topPadding: 0,
                ),
              ],
            ),
          ),
          SizedBox(height: space),
          TextInputBox(
            topPadding: 0,
            title: "Garag  Rent*",
            textType: TextInputType.number,
            hintText: "3,000 ৳",
            titlelenth: 4,
            suffixtext: "৳",
            controller: postController.rentTolet,
            numberFormatter: ThousandsFormatter(),
            iconh: 23,
            iconw: 23,
            widthh: 1.2,
          ),
        ],
      );
    } else if (postController.categoriesSortTolet['Office']!.value &&
        postController.categories['Family']!.value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: space),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropDownBtn(
                title: "Bedroom *",
                category: Category.bedrooms,
                widthh: 2.35,
                topPadding: 0,
              ),
              DropDownBtn(
                title: "Bathroom",
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
              DropDownBtn(
                title: "Dining",
                category: Category.dining,
                widthh: 2.35,
                topPadding: 0,
              ),
              DropDownBtn(
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
              DropDownBtn(
                title: "Floor No",
                category: Category.floorno,
                widthh: 2.35,
                topPadding: 0,
              ),
              DropDownBtn(
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
                TextInputBox(
                  topPadding: 0,
                  // title: "Room Size (ft\u00b2)",
                  title: "Room Size ",
                  textType: TextInputType.text,
                  hintText: "12x12 or ft\u00b2",
                  titlelenth: 500,
                  suffixtext: "",
                  controller: postController.roomSizeTolet,
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
                                DateFormat().add_MMMd().format(DateTime.now()),
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
                TextInputBox(
                  topPadding: 0,
                  title: "Maintenance(Monthly)",
                  textType: TextInputType.number,
                  hintText: "300",
                  titlelenth: 4,
                  suffixtext: "",
                  controller: postController.maintenanceTolet,
                  numberFormatter: ThousandsFormatter(),
                  iconh: 23,
                  iconw: 23,
                  widthh: 2.35,
                ),
                SizedBox(width: space),
                TextInputBox(
                  topPadding: 0,
                  title: "Rent *",
                  textType: TextInputType.number,
                  hintText: "20,000 ৳",
                  titlelenth: 500,
                  suffixtext: "৳",
                  controller: postController.rentTolet,
                  numberFormatter: ThousandsFormatter(),
                  iconh: 23,
                  iconw: 23,
                  widthh: 2.35,
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
                  children: postController.fasalitisTolet.entries.map((entry) {
                    final String text = entry.key;
                    final FasalitisTolet fasalitisTolet = entry.value;
                    final categoryState = fasalitisTolet.state;

                    return FasalitisToletChip(
                      text: text,
                      icon: fasalitisTolet.icon,
                      categoryState: categoryState,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      );
    } else if (postController.categories['Office']!.value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: space),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropDownBtn(
                title: "Room",
                category: Category.bedrooms,
                widthh: 2.35,
                topPadding: 0,
              ),
              DropDownBtn(
                title: "Bathroom",
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
              DropDownBtn(
                title: "Floor No",
                category: Category.floorno,
                widthh: 2.35,
                topPadding: 0,
              ),
              DropDownBtn(
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
                TextInputBox(
                  topPadding: 0,
                  title: "Room Size",
                  textType: TextInputType.text,
                  hintText: "12x12 or ft\u00b2",
                  titlelenth: 500,
                  suffixtext: "",
                  controller: postController.roomSizeTolet,
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
                                DateFormat().add_MMMd().format(DateTime.now()),
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
                TextInputBox(
                  topPadding: 0,
                  title: "Maintenance(Monthly)",
                  textType: TextInputType.number,
                  hintText: "300",
                  titlelenth: 4,
                  suffixtext: "",
                  controller: postController.maintenanceTolet,
                  numberFormatter: ThousandsFormatter(),
                  iconh: 23,
                  iconw: 23,
                  widthh: 2.35,
                ),
                SizedBox(width: space),
                TextInputBox(
                  topPadding: 0,
                  title: "Rent *",
                  textType: TextInputType.number,
                  hintText: "20,000 ৳",
                  titlelenth: 500,
                  suffixtext: "৳",
                  controller: postController.rentTolet,
                  numberFormatter: ThousandsFormatter(),
                  iconh: 23,
                  iconw: 23,
                  widthh: 2.35,
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
                  children: postController.fasalitisTolet.entries.map((entry) {
                    final String text = entry.key;
                    final FasalitisTolet fasalitisTolet = entry.value;
                    final categoryState = fasalitisTolet.state;

                    return FasalitisToletChip(
                      text: text,
                      icon: fasalitisTolet.icon,
                      categoryState: categoryState,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      );
    } else if (postController.categories['Shop']!.value) {
      return Column(
        children: [
          SizedBox(height: space),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropDownBtn(
                title: "Floor No *",
                category: Category.floorno,
                widthh: 2.35,
                topPadding: 0,
              ),
              DropDownBtn(
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
                TextInputBox(
                  topPadding: 0,
                  title: "Room Size",
                  textType: TextInputType.text,
                  hintText: "12x12 or ft\u00b2",
                  titlelenth: 500,
                  suffixtext: "",
                  controller: postController.roomSizeTolet,
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
                                DateFormat().add_MMMd().format(DateTime.now()),
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
          TextInputBox(
            topPadding: 0,
            title: "Rent *",
            textType: TextInputType.number,
            hintText: "20,000 ৳",
            titlelenth: 500,
            suffixtext: "৳",
            controller: postController.rentTolet,
            numberFormatter: ThousandsFormatter(),
            iconh: 23,
            iconw: 23,
            widthh: 1.2,
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
              DropDownBtn(
                title: "Bedroom *",
                category: Category.bedrooms,
                widthh: 2.35,
                topPadding: 0,
              ),
              DropDownBtn(
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
              DropDownBtn(
                title: "Dining",
                category: Category.dining,
                widthh: 2.35,
                topPadding: 0,
              ),
              DropDownBtn(
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
              DropDownBtn(
                title: "Floor No",
                category: Category.floorno,
                widthh: 2.35,
                topPadding: 0,
              ),
              DropDownBtn(
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
                TextInputBox(
                  topPadding: 0,
                  title: "Room Size",
                  textType: TextInputType.text,
                  hintText: "12x12 or ft\u00b2",
                  titlelenth: 500,
                  suffixtext: "ft\u00b2",
                  controller: postController.roomSizeTolet,
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
                                DateFormat().add_MMMd().format(DateTime.now()),
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
                TextInputBox(
                  topPadding: 0,
                  title: "Maintenance(Monthly)",
                  textType: TextInputType.number,
                  hintText: "300",
                  titlelenth: 4,
                  suffixtext: "",
                  controller: postController.maintenanceTolet,
                  numberFormatter: ThousandsFormatter(),
                  iconh: 23,
                  iconw: 23,
                  widthh: 2.35,
                ),
                SizedBox(width: space),
                TextInputBox(
                  topPadding: 0,
                  title: "Rent *",
                  textType: TextInputType.number,
                  hintText: "20,000 ৳",
                  titlelenth: 500,
                  suffixtext: "৳",
                  controller: postController.rentTolet,
                  numberFormatter: ThousandsFormatter(),
                  iconh: 23,
                  iconw: 23,
                  widthh: 2.35,
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
                  children: postController.fasalitisTolet.entries.map((entry) {
                    final String text = entry.key;
                    final FasalitisTolet fasalitisTolet = entry.value;
                    final categoryState = fasalitisTolet.state;

                    return FasalitisToletChip(
                      text: text,
                      icon: fasalitisTolet.icon,
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
}
