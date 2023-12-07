import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/model/postmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'widget/chips.dart';
import 'widget/dropdown.dart';
import 'widget/image.dart';
import 'widget/textbox.dart';

class PostProperty1 extends StatefulWidget {
  const PostProperty1({super.key});

  @override
  State<PostProperty1> createState() => _PostProperty1State();
}

class _PostProperty1State extends State<PostProperty1> {
  final PostController postController = Get.find();
  double space = 20.0;
  // ignore: unused_field
  DateTime? _chosenDateTime;
  // ignore: unused_element
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
                        postController.availableFrom = _chosenDateTime!;
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
  void initState() {
    postController.availableFrom = DateTime.now();
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
                    borderRadius: BorderRadius.circular(100)),
                elevation: 0,
                onPressed: () async {
                  postController.pageControllerProperty.nextPage(
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
                PorpertyChips(
                  categorylist: postController.category,
                  title: 'Category *',
                ),
                postController.iscategory.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          TextInputBoxProperty(
                            topPadding: 0,
                            title: "Property Name",
                            textType: TextInputType.text,
                            hintText: "Modern Apartment",
                            titlelenth: 500,
                            suffixtext: "",
                            controller: postController.propertyNameProperty,
                            iconh: 23,
                            iconw: 23,
                            widthh: 2.35 / 2,
                          ),
                          const ChipsType(),
                          const ChipsRooms(
                            title: 'Bedroom',
                            icon: Icons.bed_outlined,
                          ),
                          const ChipsBath(
                            title: 'Bathroom',
                            icon: Icons.bathtub_outlined,
                          ),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                DragdownBoxPropertyPage(
                                  title: "Dining",
                                  catagoryName: diningProperty,
                                  widthh: 2.35,
                                  topPadding: 0,
                                ),
                                SizedBox(width: space),
                                DragdownBoxPropertyPage(
                                  title: "Kitcen",
                                  catagoryName: kitchenProperty,
                                  widthh: 2.35,
                                  topPadding: 0,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextInputBoxProperty(
                                  topPadding: 0,
                                  title: "SIZE",
                                  textType: TextInputType.text,
                                  hintText: "12x12 or ft\u00b2",
                                  titlelenth: 500,
                                  suffixtext: "",
                                  controller: postController.sizeOfHomeProperty,
                                  iconh: 23,
                                  iconw: 23,
                                  widthh: 2.35,
                                ),
                                SizedBox(width: space),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Available From',
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
                                          backgroundColor:
                                              const Color(0xffF2F3F5),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
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
                                TextInputBoxProperty(
                                  topPadding: 0,
                                  title: "Total Floor",
                                  textType: TextInputType.number,
                                  hintText: "12",
                                  titlelenth: 500,
                                  suffixtext: "",
                                  controller: postController.totalFloorProperty,
                                  iconh: 23,
                                  iconw: 23,
                                  widthh: 2.35,
                                ),
                                SizedBox(width: space),
                                TextInputBoxProperty(
                                  topPadding: 0,
                                  title: "Floor Number",
                                  textType: TextInputType.number,
                                  hintText: "12",
                                  titlelenth: 500,
                                  suffixtext: "th",
                                  controller:
                                      postController.floorNumberProperty,
                                  iconh: 23,
                                  iconw: 23,
                                  widthh: 2.35,
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
                                DragdownBoxPropertyPage(
                                  title: "Facing",
                                  catagoryName: facingProperty,
                                  widthh: 2.35,
                                  topPadding: 0,
                                ),
                                SizedBox(width: space),
                                TextInputBoxProperty(
                                  topPadding: 0,
                                  title: "Total Unit",
                                  textType: TextInputType.number,
                                  hintText: "3",
                                  titlelenth: 500,
                                  suffixtext: "Unit",
                                  controller: postController.totalUnitProperty,
                                  iconh: 23,
                                  iconw: 23,
                                  widthh: 2.35,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: space),
                          TextInputBoxProperty(
                            topPadding: 0,
                            title: "Price *",
                            textType: TextInputType.number,
                            hintText: "20,000 ৳",
                            titlelenth: 500,
                            suffixtext: "৳",
                            controller: postController.priceProperty,
                            iconh: 23,
                            iconw: 23,
                            widthh: 2.35 / 2,
                          ),
                          SizedBox(height: space),
                          const Text(
                            'Aminities(op)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: space),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Wrap(
                                  spacing: 10,
                                  children: postController
                                      .fasalitisProperty.entries
                                      .map((entry) {
                                    final String text = entry.key;
                                    final FasalitisTolet fasalitisTolet =
                                        entry.value;
                                    final categoryState = fasalitisTolet.state;

                                    return FasalitisPropertyChip(
                                      text: text,
                                      icon: fasalitisTolet.icon,
                                      categoryState: categoryState,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: space),
                          TextInputBoxProperty(
                            topPadding: 0,
                            title: "Youtube Video",
                            textType: TextInputType.text,
                            hintText:
                                "https://youtu.be/G9F8VtqNhzo?si=Yt-rWrB0Wy1x4fi3",
                            titlelenth: 500,
                            suffixtext: "...",
                            controller: postController.ytVideoProperty,
                            iconh: 23,
                            iconw: 23,
                            widthh: 1.2,
                            // icon: Feather.youtube,
                          ),
                          SizedBox(height: space),
                          Row(
                            children: [
                              SizedBox(
                                height: 18,
                                width: 18,
                                child: SvgPicture.asset(
                                  'assets/icons/floors.svg',
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xff083437),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Select floor Plan (Optional)',
                                style: TextStyle(
                                  color: Color(0xff7B7B7B),
                                  letterSpacing: 0.7,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: space),
                          const SelectImageFloorPlan(
                            icon: Feather.image,
                            imagnumber: 1,
                            // color: Colors.red,
                            // color: Color(0xff279EFF),
                            color: Colors.orange,
                          ),
                          SizedBox(height: space),
                          const Text(
                            'Select Image',
                            style: TextStyle(
                              color: Color(0xff7B7B7B),
                              letterSpacing: 0.7,
                            ),
                          ),
                          SizedBox(height: space),
                          const SelectImageProperty(
                            icon: Feather.image,
                            imagnumber: 12,
                            color: Color(0xff5E72E4),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ChipsLandType(),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DragdownBoxPropertyPage(
                                  title: "Area",
                                  catagoryName: area,
                                  widthh: 2.35,
                                  topPadding: 0,
                                ),
                                SizedBox(width: space),
                                TextInputBoxProperty(
                                  topPadding: 0,
                                  title: "Mesurement",
                                  textType: TextInputType.number,
                                  hintText: "20,000",
                                  titlelenth: 500,
                                  suffixtext: "",
                                  controller: postController.mesurementProperty,
                                  iconh: 23,
                                  iconw: 23,
                                  widthh: 2.35,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const RodeSizeBox(),
                          const SizedBox(height: 20),
                          TextInputBoxProperty(
                            topPadding: 0,
                            title: "Total Price *",
                            textType: TextInputType.number,
                            hintText: "20,000 ৳",
                            titlelenth: 500,
                            suffixtext: "৳",
                            controller: postController.priceProperty,
                            iconh: 23,
                            iconw: 23,
                            widthh: 2.35 / 2,
                          ),
                          SizedBox(height: space),
                          TextInputBoxProperty(
                            topPadding: 0,
                            title: "Youtube Video",
                            textType: TextInputType.text,
                            hintText:
                                "https://youtu.be/G9F8VtqNhzo?si=Yt-rWrB0Wy1x4fi3",
                            titlelenth: 500,
                            suffixtext: "",
                            controller: postController.ytVideoProperty,
                            iconh: 23,
                            iconw: 23,
                            widthh: 1.2,
                            // icon: Feather.youtube,
                          ),
                          SizedBox(height: space),
                          const Text(
                            'Optional',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Wrap(
                                  spacing: 10,
                                  children: postController
                                      .fasalitisProperty2.entries
                                      .map((entry) {
                                    final String text = entry.key;
                                    final FasalitisTolet fasalitisTolet =
                                        entry.value;
                                    final categoryState = fasalitisTolet.state;

                                    return FasalitisPropertyChip(
                                      text: text,
                                      icon: fasalitisTolet.icon,
                                      categoryState: categoryState,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: space),
                          const Text(
                            'Select Image',
                            style: TextStyle(
                              color: Color(0xff7B7B7B),
                              letterSpacing: 0.7,
                            ),
                          ),
                          SizedBox(height: space),
                          const SelectImageProperty(
                            icon: Feather.image,
                            imagnumber: 12,
                            color: Color(0xff5E72E4),
                          ),
                        ],
                      ),
                const SizedBox(height: 300),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
