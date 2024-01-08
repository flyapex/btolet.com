import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TextInput extends StatefulWidget {
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
  final String svgicon;
  final FocusNode focusNode;
  const TextInput({
    super.key,
    required this.title,
    required this.hintText,
    required this.textType,
    this.topPadding = 10,
    required this.controller,
    required this.suffixtext,
    required this.titlelenth,
    required this.iconh,
    required this.iconw,
    required this.widthh,
    this.numberFormatter,
    required this.svgicon,
    required this.focusNode,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  ToletController toletController = Get.find();
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
    if (widget.controller == toletController.rent) {
      return toletController.activeFlag.value
          ? toletController.priceFlag.value
              ? Colors.white
              : Colors.red
          : Colors.white;
    } else {
      return Colors.white;
    }
  }

  getFocus() {
    final focusNodeMap = {
      toletController.namefocusNode: toletController.roomSizefocusNode,
      toletController.roomSizefocusNode: toletController.maintenancefocusNode,
      toletController.maintenancefocusNode: toletController.rentfocusNode,
      toletController.rentfocusNode: userController.descriptionfocusNode,
      userController.shortaddressfocusNode: userController.phonefocusNode,
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
              widget.svgicon != ''
                  ? Container(
                      height: widget.iconh,
                      width: widget.iconw,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: SvgPicture.asset(
                        widget.svgicon,
                        colorFilter: ColorFilter.mode(
                          iconColorChange
                              ? Colors.blueAccent
                              : Colors.black.withOpacity(0.5),
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : const SizedBox(),
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
                    inputFormatters: [
                      if (widget.numberFormatter != null)
                        widget.numberFormatter!,
                    ],
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
                      if (val != '' &&
                          toletController.rent == widget.controller) {
                        toletController.priceFlag.value = true;
                        // postController.istitletxt.value == true;
                        // widget.flag = true;
                        // postController.page2chack();
                      }
                      // postController.allCategoryCheck();
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
