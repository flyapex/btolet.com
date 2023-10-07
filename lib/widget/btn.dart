import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/model/postmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../pages/map/location_sheet_map.dart';

class DragdownBoxSmall extends StatefulWidget {
  final String title;
  final double topPadding;
  final List catagoryName;
  final double widthh;
  const DragdownBoxSmall({
    super.key,
    required this.title,
    this.topPadding = 10.0,
    required this.catagoryName,
    required this.widthh,
  });

  @override
  State<DragdownBoxSmall> createState() => _DragdownBoxSmallState();
}

class _DragdownBoxSmallState extends State<DragdownBoxSmall> {
  final PostController postController = Get.find();

  var textstylemain = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: 15,
    letterSpacing: 1.2,
    color: Colors.black.withOpacity(0.7),
  );
  var textstyleh = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: 15,
    letterSpacing: 1.2,
    color: Colors.black.withOpacity(0.6),
  );

  getText() {
    if (widget.catagoryName == rooms) {
      return postController.rooms.value;
    } else if (widget.catagoryName == bath) {
      return postController.bath.value;
    } else if (widget.catagoryName == floors) {
      return postController.floors.value;
    } else if (widget.catagoryName == facing) {
      return postController.facing.value;
    } else if (widget.catagoryName == kitchen) {
      return postController.kitchen.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    getTextList() {
      if (widget.catagoryName == rooms) {
        return rooms;
      } else if (widget.catagoryName == bath) {
        return bath;
      } else if (widget.catagoryName == floors) {
        return floors;
      } else if (widget.catagoryName == facing) {
        return facing;
      } else if (widget.catagoryName == kitchen) {
        return kitchen;
      }
    }

    return Obx(
      (() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: widget.topPadding)),
            Text(
              widget.title,
              style: TextStyle(
                letterSpacing: 0.7,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffF2F3F5),
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 48,
                    width: (Get.width / widget.widthh),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          isExpanded: true,
                          icon: Icon(
                            Feather.chevron_down,
                            color: Colors.black.withOpacity(0.4),
                          ),
                          hint: Text(
                            getText(),
                            style: getText() == 'select'
                                ? textstyleh
                                : textstylemain,
                          ),
                          items: getTextList()?.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (widget.catagoryName == rooms) {
                              postController.rooms.value = val.toString();
                            } else if (widget.catagoryName == bath) {
                              postController.bath.value = val.toString();
                            } else if (widget.catagoryName == floors) {
                              postController.floors.value = val.toString();
                            } else if (widget.catagoryName == facing) {
                              postController.facing.value = val.toString();
                            } else if (widget.catagoryName == kitchen) {
                              postController.kitchen.value = val.toString();
                            }
                            // postController.allCategoryCheck();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

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

class SmallTextBox extends StatefulWidget {
  final String title;
  final int titlelenth;
  final String hintText;
  final String suffixtext;
  final TextInputType textType;
  final double topPadding;
  final TextEditingController controller;
  final double iconh;
  final double iconw;
  final double widthh;

  const SmallTextBox({
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
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SmallTextBoxState createState() => _SmallTextBoxState();
}

class _SmallTextBoxState extends State<SmallTextBox> {
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
  // checkFlagColor() {
  //   if (widget.title == 'Maintenance(Monthly) *' &&
  //       postController.maintenanceFlag.value == false) {
  //     return Colors.redAccent;
  //   } else if (widget.title == 'Price *' &&
  //       postController.priceFlag.value == false) {
  //     return Colors.redAccent;
  //   } else if (widget.title == 'Short Address *' &&
  //       postController.shortaddressFlag.value == false) {
  //     return Colors.redAccent;
  //   } else {
  //     return Colors.white;
  //   }
  // }

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
              color: Colors.white,
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
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(widget.titlelenth),
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
            ],
          ),
        ),
      ],
    );
  }
}

class DescriptionTextBox extends StatefulWidget {
  final String title;
  final IconData icon;
  final String hintText;
  final TextInputType textType;
  final TextEditingController controller;
  const DescriptionTextBox(
      {Key? key,
      required this.title,
      required this.icon,
      required this.hintText,
      required this.textType,
      required this.controller})
      : super(key: key);

  @override
  DescriptionTextBoxState createState() => DescriptionTextBoxState();
}

class DescriptionTextBoxState extends State<DescriptionTextBox> {
  PostController postController = Get.find();
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
  var iconColorChange = false;
  var focusNode = FocusNode();
  // checkFlagColor() {
  //   if (postController.desFlag.value == false) {
  //     return Colors.redAccent;
  //   } else {
  //     return Colors.white;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            letterSpacing: 0.7,
          ),
        ),
        const SizedBox(height: 15),
        InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(focusNode);
          },
          child: Container(
            height: 170,
            width: Get.width,
            decoration: BoxDecoration(
              color: const Color(0xffF2F3F5),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    margin: const EdgeInsets.only(left: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      widget.icon,
                      color: iconColorChange
                          ? Colors.blueAccent
                          : Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Expanded(
                    child: Focus(
                      onFocusChange: (val) {
                        setState(() {
                          val
                              ? iconColorChange = true
                              : iconColorChange = false;
                        });
                        // postController.allCategoryCheck();
                      },
                      child: TextField(
                        focusNode: focusNode,
                        cursorHeight: 22,
                        cursorWidth: 1.8,
                        cursorRadius: const Radius.circular(10),
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 100,
                        controller: widget.controller,
                        textInputAction: TextInputAction.none,
                        cursorColor: Colors.black,
                        style: textstyle,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 30),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                          hintText: widget.hintText,
                          hintStyle: textstyleh,
                        ),
                        onChanged: (v) {
                          // postController.page2chack();
                          // postController.allCategoryCheck();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
