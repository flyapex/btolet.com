import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextInputPro extends StatefulWidget {
  final String title;
  final int textlength;
  final String hintText;
  final String suffixtext;
  final TextInputType textType;
  final double topPadding;
  final TextEditingController controller;
  final TextInputFormatter? numberFormatter;
  final double widthh;
  final FocusNode focusNode;
  const TextInputPro({
    super.key,
    required this.title,
    required this.hintText,
    required this.textType,
    this.topPadding = 10,
    required this.controller,
    required this.suffixtext,
    required this.textlength,
    required this.widthh,
    this.numberFormatter,
    required this.focusNode,
  });

  @override
  State<TextInputPro> createState() => _TextInputProState();
}

class _TextInputProState extends State<TextInputPro> {
  ProController proController = Get.find();
  UserController userController = Get.find();
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
    if (widget.controller == proController.totalSize) {
      return proController.activeFlag.value
          ? proController.totalsizeFlag.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    }

    if (widget.controller == proController.totalFloor) {
      return proController.activeFlag.value
          ? proController.totalfloorFlag.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    }
    if (widget.controller == proController.floorNumber) {
      return proController.activeFlag.value
          ? proController.floornumberFlag.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    }
    if (widget.controller == proController.totalUnit) {
      return proController.activeFlag.value
          ? proController.totalUnitFlag.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    }
    if (widget.controller == proController.mesurement) {
      return proController.activeFlag.value
          ? proController.mesurementFlag.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    }
    if (widget.controller == proController.roadSize) {
      return proController.activeFlag.value
          ? proController.rodeSizeFlag.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    }
    if (widget.controller == proController.price) {
      return proController.activeFlag.value
          ? proController.priceFlag.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    } else {
      return Colors.white;
    }
  }

  getFocus() {
    final focusNodeMap = {
      proController.namefocusNode: proController.totalFloorfocusNode,
      proController.totalFloorfocusNode: proController.floorNumberfocusNode,
      proController.floorNumberfocusNode: proController.totalSizefocusNode,
      proController.totalSizefocusNode: proController.totalUnitfocusNode,
      proController.totalUnitfocusNode: proController.pricefocusNode,
      proController.pricefocusNode: proController.ytVideofocusNode,
      userController.shortaddressfocusNode: userController.descriptionfocusNode,
      proController.mesurementfocusNode: proController.roadSizefocusNode,
      proController.roadSizefocusNode: proController.pricefocusNode,
      proController.pricefocusNode: proController.ytVideofocusNode,
    };

    final nextFocusNode = focusNodeMap[widget.focusNode];

    if (nextFocusNode != null) {
      FocusScope.of(context).requestFocus(nextFocusNode);
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
                    focusNode: widget.focusNode,
                    // inputFormatters: [
                    //   LengthLimitingTextInputFormatter(widget.titlelenth),
                    // ],

                    // inputFormatters: [ThousandsFormatter()],
                    inputFormatters: [
                      if (widget.numberFormatter != null)
                        widget.numberFormatter!,
                    ],
                    maxLength: widget.textlength,
                    cursorHeight: 24,
                    cursorWidth: 1.8,
                    cursorRadius: const Radius.circular(10),
                    controller: widget.controller,
                    textInputAction: TextInputAction.done,
                    keyboardType: widget.textType,
                    maxLines: 1,
                    cursorColor: Colors.black,
                    style: textstyle,
                    decoration: InputDecoration(
                      counterText: '',
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
                      if (userController.shortAddress == widget.controller ||
                          userController.description == widget.controller ||
                          userController.phonenumber == widget.controller ||
                          userController.wappnumber == widget.controller) {
                      } else if (val != '') {
                        proController.flagCheck();
                      }
                    },
                    onSubmitted: (v) {
                      getFocus();
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
