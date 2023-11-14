import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/model/postmodel.dart';
import 'package:btolet/pages/sorting/sortingproperty.dart';
import 'package:btolet/pages/post/tolet/widget/textbox.dart';
import 'package:btolet/widget/btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'widget/btn.dart';

class PostProperty1 extends StatefulWidget {
  const PostProperty1({super.key});

  @override
  State<PostProperty1> createState() => _PostProperty1State();
}

class _PostProperty1State extends State<PostProperty1> {
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
    return Obx(
      () => Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: space),
                Text(
                  'Category *',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 20),
                const PorpertyChips(),
                !postController.categoryIndex.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableChipsType(
                            categorylist: landtype,
                          ),
                          // SelectableChipsType(
                          //   categorylist: area,
                          // ),
                          const SizedBox(height: 20),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AreaBox(
                                  title: "Area",
                                  catagoryName: area,
                                  widthh: 2.35,
                                  topPadding: 0,
                                ),
                                SizedBox(width: space),
                                TextInputBox(
                                  topPadding: 0,
                                  title: "Mesurement",
                                  textType: TextInputType.number,
                                  hintText: "20,000",
                                  titlelenth: 500,
                                  suffixtext: "sqf",
                                  controller: postController.price,
                                  iconh: 23,
                                  iconw: 23,
                                  widthh: 2.35,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const PriceBox(),
                          const SizedBox(height: 20),
                          TextInputBox(
                            topPadding: 0,
                            title: "Rode Size",
                            textType: TextInputType.number,
                            hintText: "20 m",
                            titlelenth: 500,
                            suffixtext: "m",
                            controller: postController.price,
                            iconh: 23,
                            iconw: 23,
                            widthh: 2.35,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Optional',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              CustomeChipPorperty(
                                text: "Electricity",
                                icon: Icons.balcony_rounded,
                              ),
                              SizedBox(width: 10),
                              CustomeChipPorperty(
                                text: "Drain",
                                icon: Icons.balcony_rounded,
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          TextInputBox(
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
                          SelectableChipsType(
                            categorylist: type,
                          ),
                          SelectableChips(
                            categorylist: prooms,
                            catagoryName: 'Bedroom',
                            icon: Icons.bed_outlined,
                          ),
                          SelectableChips(
                            categorylist: prooms,
                            catagoryName: 'Bathroom',
                            icon: Icons.bathtub_outlined,
                          ),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                DragdownBoxProperty(
                                  title: "Dining",
                                  catagoryName: diningProperty,
                                  widthh: 2.35,
                                  topPadding: 0,
                                ),
                                SizedBox(width: space),
                                DragdownBoxProperty(
                                  title: "Kitchen",
                                  catagoryName: diningProperty,
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
                                TextInputBox(
                                  topPadding: 0,
                                  title: "SIZE (ft\u00b2)",
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
                                TextInputBox(
                                  topPadding: 0,
                                  title: "Total Floor",
                                  textType: TextInputType.number,
                                  hintText: "12",
                                  titlelenth: 500,
                                  suffixtext: "th",
                                  controller: postController.price,
                                  iconh: 23,
                                  iconw: 23,
                                  widthh: 2.35,
                                ),
                                SizedBox(width: space),
                                TextInputBox(
                                  topPadding: 0,
                                  title: "Floor Number",
                                  textType: TextInputType.number,
                                  hintText: "12",
                                  titlelenth: 500,
                                  suffixtext: "th",
                                  controller: postController.price,
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
                                DragdownBoxProperty(
                                  title: "Facing",
                                  catagoryName: diningProperty,
                                  widthh: 2.35,
                                  topPadding: 0,
                                ),
                                SizedBox(width: space),
                                TextInputBox(
                                  topPadding: 0,
                                  title: "Total Unit",
                                  textType: TextInputType.number,
                                  hintText: "3",
                                  titlelenth: 500,
                                  suffixtext: "Unit",
                                  controller: postController.price,
                                  iconh: 23,
                                  iconw: 23,
                                  widthh: 2.35,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: space),
                          TextInputBox(
                            topPadding: 0,
                            title: "Price *",
                            textType: TextInputType.number,
                            hintText: "20,000 ৳",
                            titlelenth: 500,
                            suffixtext: "৳",
                            controller: postController.price,
                            iconh: 23,
                            iconw: 23,
                            widthh: 2.35,
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
                                      icon:
                                          Icons.local_fire_department_outlined,
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
                          SizedBox(height: space),
                        ],
                      ),

                // const Text(
                //   'Select image *',
                //   style: TextStyle(
                //     color: Color(0xff7B7B7B),
                //     letterSpacing: 0.7,
                //   ),
                // ),
                // const SizedBox(height: 10),
                // const SelectImage(
                //   icon: Feather.camera,
                //   imagnumber: 1,
                // ),
                SizedBox(height: space),
                Row(
                  children: [
                    SizedBox(
                      height: 18,
                      width: 18,
                      child: SvgPicture.asset(
                        'assets/icons/floor.svg',
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
                const SelectImageProperty(
                  icon: Feather.image,
                  imagnumber: 12,
                  // color: Colors.red,
                  // color: Color(0xff279EFF),
                  color: Colors.amber,
                ),
                SizedBox(height: space),
                TextInputBox(
                  topPadding: 0,
                  title: "YT Video",
                  textType: TextInputType.number,
                  hintText: "https://youtu.be/G9F8VtqNhzo?si=Yt-rWrB0Wy1x4fi3",
                  titlelenth: 500,
                  suffixtext: "Unit",
                  controller: postController.price,
                  iconh: 23,
                  iconw: 23,
                  widthh: 1.2,
                  // icon: Feather.youtube,
                ),

                SizedBox(height: space),
                const SelectVideoProperty(
                  icon: Feather.play_circle,
                  videoNumber: 1,
                  color: Color(0xff4E4FEB),
                ),
                SizedBox(height: space),
                const SelectImageProperty(
                  icon: Feather.image,
                  imagnumber: 12,
                  color: Color(0xff4E4FEB),
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
