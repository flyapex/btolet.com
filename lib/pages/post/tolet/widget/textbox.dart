import 'package:btolet/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextInputBox extends StatefulWidget {
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

  const TextInputBox({
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
  _TextInputBoxState createState() => _TextInputBoxState();
}

class _TextInputBoxState extends State<TextInputBox> {
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
    if (widget.controller == postController.rentTolet) {
      return postController.flagActiveFlag.value
          ? postController.priceFlag.value
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
                      postController.allToletFlagCheck();
                      if (val != '') {
                        // postController.istitletxt.value == true;
                        // widget.flag = true;
                        // postController.page2chack();
                      }
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
