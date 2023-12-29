import 'package:btolet/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TextInputBoxProperty extends StatefulWidget {
  final String title;
  final int titlelenth;
  final String hintText;
  final String suffixtext;
  final TextInputType textType;
  final double topPadding;
  final TextEditingController controller;
  final TextInputFormatter? numberFormatter;
  final double iconh;
  final double iconw;
  final double widthh;

  const TextInputBoxProperty({
    required this.title,
    required this.hintText,
    required this.textType,
    this.topPadding = 10,
    required this.controller,
    required this.suffixtext,
    required this.titlelenth,
    required this.iconh,
    required this.iconw,
    Key? key,
    required this.widthh,
    this.numberFormatter,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TextInputBoxPropertyState createState() => _TextInputBoxPropertyState();
}

class _TextInputBoxPropertyState extends State<TextInputBoxProperty> {
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
  getBorderColor() {
    if (widget.controller == postController.sizeOfHomeProperty) {
      return postController.flagActiveFlagProperty.value
          ? postController.sizeFlagProperty.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    }

    if (widget.controller == postController.totalFloorProperty) {
      return postController.flagActiveFlagProperty.value
          ? postController.totalfloorFlagProperty.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    }
    if (widget.controller == postController.floorNumberProperty) {
      return postController.flagActiveFlagProperty.value
          ? postController.floorNumberFlagProperty.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    }
    if (widget.controller == postController.totalUnitProperty) {
      return postController.flagActiveFlagProperty.value
          ? postController.totalUnitFlagProperty.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    }
    if (widget.controller == postController.priceProperty) {
      return postController.flagActiveFlagProperty.value
          ? postController.priceFlagProperty.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    }
    if (widget.controller == postController.mesurementProperty) {
      return postController.flagActiveFlagProperty.value
          ? postController.mesurementFlagProperty.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.topPadding),
        Text(
          widget.title,
          style: TextStyle(
            letterSpacing: 0.7,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffF2F3F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: getBorderColor(),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 48,
                width: (Get.width / widget.widthh),
                child: Focus(
                  onFocusChange: (val) {
                    setState(() {
                      val ? iconColorChange = true : iconColorChange = false;
                    });
                  },
                  child: TextField(
                    // inputFormatters: [
                    //   LengthLimitingTextInputFormatter(widget.titlelenth),
                    // ],

                    // inputFormatters: [ThousandsFormatter()],
                    inputFormatters: [
                      if (widget.numberFormatter != null)
                        widget.numberFormatter!,
                    ],
                    // maxLength: widget.titlelenth,
                    cursorHeight: 24,
                    cursorWidth: 1.8,
                    cursorRadius: const Radius.circular(10),
                    controller: widget.controller,
                    textInputAction: TextInputAction.next,
                    keyboardType: widget.textType,
                    maxLines: 1,
                    cursorColor: Colors.black,
                    style: textstyle,
                    decoration: InputDecoration(
                      suffix: Text(
                        widget.suffixtext,
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
                      hintText: widget.hintText,
                      hintStyle: textstyleh,
                    ),
                    onChanged: (val) {
                      // postController.alltextfield();
                      if (val != '') {
                        // postController.istitletxt.value == true;
                        // widget.flag = true;
                        // postController.page2chack();
                      }
                      // postController.allCategoryCheck();
                      var currentPageIndex =
                          postController.pageControllerProperty.page?.round() ??
                              0;
                      print(currentPageIndex);
                      if (currentPageIndex == 0) {
                        postController.allToletFlagCheckProperty();
                      } else {}
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RodeSizeBox extends StatefulWidget {
  const RodeSizeBox({super.key});

  @override
  State<RodeSizeBox> createState() => _RodeSizeBoxState();
}

class _RodeSizeBoxState extends State<RodeSizeBox> {
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
  getBorderColor() {
    return postController.flagActiveFlagProperty.value
        ? postController.roadSizeFlagProperty.value
            ? Colors.white
            : Colors.red
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xffF2F3F5),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    "Front Rode Size *",
                    style: TextStyle(
                      letterSpacing: 0.7,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF2F3F5),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: getBorderColor(),
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
                      controller: postController.rodeSizeProperty,
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
                        hintText: "20 m",
                        hintStyle: textstyleh,
                      ),
                      onChanged: (val) {},
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

class NumberBoxProperty extends StatefulWidget {
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
  const NumberBoxProperty({
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
    super.key,
  });

  @override
  State<NumberBoxProperty> createState() => _NumberBoxPropertyState();
}

class _NumberBoxPropertyState extends State<NumberBoxProperty> {
  final PostController postController = Get.find();
  var hinttex = '017xxxxxxxx';
  var iconColorChange = false;
  var textstyle = const TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    fontSize: 16,
    letterSpacing: 1.2,
  );
  var textstyleh = const TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    fontSize: 15,
    letterSpacing: 1.2,
  );
  getBorderColor() {
    return postController.flagActiveFlagProperty.value
        ? postController.phoneFlagProperty.value
            ? Colors.white
            : Colors.red
        : Colors.white;
  }

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
                  border: Border.all(color: getBorderColor()),
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
                        onEditingComplete: () {
                          postController.allToletFlagCheckProperty();
                        },
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
