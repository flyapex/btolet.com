import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../pages/map/location_sheet_map.dart';

class PriceBox extends StatefulWidget {
  const PriceBox({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PriceBoxState createState() => _PriceBoxState();
}

class _PriceBoxState extends State<PriceBox> {
  PostController postController = Get.find();
  var textstyle = TextStyle(
    overflow: TextOverflow.ellipsis,
    color: Colors.black.withOpacity(0.5),
    height: 1.2,
    fontSize: 16,
    letterSpacing: 1.2,
  );
  var textstyleh = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: 15,
    letterSpacing: 1.2,
    color: Colors.black.withOpacity(0.5),
  );
  var iconColorChange = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Container(
            height: 48,
            width: Get.width / 3,
            decoration: BoxDecoration(
              color: const Color(0xffF2F3F5),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Center(
              child: Text(
                "Total Price ",
                style: TextStyle(
                  letterSpacing: 0.7,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF2F3F5),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Expanded(
                child: SizedBox(
                  height: 48,
                  width: (Get.width),
                  child: Focus(
                    onFocusChange: (val) {
                      setState(() {
                        val ? iconColorChange = true : iconColorChange = false;
                      });
                    },
                    child: TextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(500),
                      ],
                      // maxLength: widget.titlelenth,
                      cursorHeight: 24,
                      cursorWidth: 1.8,
                      cursorRadius: const Radius.circular(10),
                      controller: postController.price,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      cursorColor: Colors.black,
                      style: textstyle,
                      decoration: InputDecoration(
                        suffix: Text(
                          "৳",
                          style: TextStyle(
                            color: iconColorChange
                                ? const Color(0xff0166EE)
                                : Colors.amber,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                        hintText: "2,000,000",
                        hintStyle: textstyleh,
                      ),
                      onChanged: (val) {
                        // if (val != '') {
                        //   // postController.istitletxt.value == true;
                        //   // widget.flag = true;
                        //   // postController.page2chack();
                        // }
                        // postController.allCategoryCheck();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LocationSmall extends StatelessWidget {
  const LocationSmall({super.key});

  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.put(LocationController());
    return Container(
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.to(
            () => const LocationSheet(),
            duration: const Duration(milliseconds: 170),
            transition: Transition.circularReveal,
            fullscreenDialog: true,
          ),
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
                        child: Text(
                          locationController.locationAddress.value,
                          style: const TextStyle(
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
    );
  }
}

class FullTextInputBoxTemp extends StatefulWidget {
  final String title;
  final String icon;
  final String hintText;
  final TextInputType textType;
  final double topPadding;
  final double bottomPadding;
  final TextEditingController controller;
  final double iconh;
  final double iconw;
  const FullTextInputBoxTemp(
      {required this.title,
      required this.icon,
      required this.textType,
      required this.hintText,
      this.topPadding = 10,
      required this.controller,
      required this.iconh,
      required this.iconw,
      Key? key,
      this.bottomPadding = 15})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FullTextInputBoxTempState createState() => _FullTextInputBoxTempState();
}

class _FullTextInputBoxTempState extends State<FullTextInputBoxTemp> {
  PostController postController = Get.find();

  var iconColorChange = false;
  var textstyle = const TextStyle(
    overflow: TextOverflow.fade,
    //! color: TextColors.maintextColor,
    height: 1.2,
    fontSize: 16,
    letterSpacing: 1.2,
  );
  var textstyleh = const TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    //! color: TextColors.hinttextColor,
    fontSize: 15,
    letterSpacing: 1.2,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.topPadding),
        Text(
          widget.title,
          style: const TextStyle(
            letterSpacing: 0.7,
          ),
        ),
        SizedBox(height: widget.bottomPadding),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xffF2F3F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white),
          ),
          child: Row(children: [
            Container(
              height: widget.iconh,
              width: widget.iconw,
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: SvgPicture.asset(
                widget.icon,
                // ignore: deprecated_member_use
                color: iconColorChange
                    ? Colors.blueAccent
                    : Colors.black.withOpacity(0.5),
              ),
            ),
            Expanded(
              child: Focus(
                onFocusChange: (val) {
                  setState(() {
                    val ? iconColorChange = true : iconColorChange = false;
                  });
                },
                child: TextField(
                  cursorHeight: 22,
                  cursorWidth: 1.8,
                  cursorRadius: const Radius.circular(10),
                  controller: widget.controller,
                  textInputAction: TextInputAction.next,
                  keyboardType: widget.textType,
                  maxLines: 1,
                  cursorColor: Colors.black,
                  style: textstyle,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    isDense: true,
                    hintText: widget.hintText,
                    hintStyle: textstyleh,
                  ),
                  onChanged: (val) {
                    // postController.page2chack();
                  },
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class NumberBox extends StatefulWidget {
  final String title;
  final String icon;
  final Color color;
  final String hintText;
  final TextInputType textType;
  final double topPadding;
  final double bottomPadding;
  final TextEditingController controller;
  final double iconh;
  final double iconw;
  const NumberBox({
    required this.title,
    required this.icon,
    required this.textType,
    required this.hintText,
    this.topPadding = 10,
    required this.controller,
    required this.iconh,
    required this.iconw,
    this.bottomPadding = 15,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<NumberBox> createState() => _NumberBoxState();
}

class _NumberBoxState extends State<NumberBox> {
  var hinttex = '017xxxxxxxx';
  var iconColorChange = false;
  var textstyle = const TextStyle(
    overflow: TextOverflow.fade,
    //! color: TextColors.maintextColor,
    height: 1.2,
    fontSize: 16,
    letterSpacing: 1.2,
  );
  var textstyleh = const TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    //! color: TextColors.hinttextColor,
    fontSize: 15,
    letterSpacing: 1.2,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.topPadding),
        Text(
          widget.title,
          style: const TextStyle(
            //! color: TextColors.taitletextColor,
            letterSpacing: 0.7,
          ),
        ),
        SizedBox(height: widget.bottomPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 48,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: const Color(0xffF2F3F5),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white),
                ),
                child: Stack(
                  children: [
                    widget.hintText == ''
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                hinttex,
                                style: textstyleh,
                              ),
                            ),
                          )
                        : Container(),
                    Focus(
                      onFocusChange: (v) {
                        widget.hintText == ''
                            ? setState(() {
                                hinttex = '';
                              })
                            : Container();
                      },
                      child: TextField(
                        autofillHints: const [
                          AutofillHints.telephoneNumber,
                        ],
                        cursorHeight: 22,
                        cursorWidth: 1.8,
                        cursorRadius: const Radius.circular(10),
                        controller: widget.controller,
                        textInputAction: TextInputAction.next,
                        keyboardType: widget.textType,
                        maxLines: 1,
                        cursorColor: Colors.black,
                        style: textstyle,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                          hintText: widget.hintText,
                          hintStyle: textstyleh,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // ignore: avoid_print
                // print('wapp');
              },
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(6),
                  // border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    widget.icon,
                    height: widget.iconh,
                    width: widget.iconw,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
