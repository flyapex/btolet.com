import 'package:btolet/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextInputBoxOnly extends StatefulWidget {
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

  const TextInputBoxOnly({
    super.key,
    required this.title,
    required this.titlelenth,
    required this.hintText,
    required this.suffixtext,
    required this.textType,
    required this.topPadding,
    required this.controller,
    required this.iconh,
    required this.iconw,
    required this.widthh,
  });

  @override
  State<TextInputBoxOnly> createState() => _TextInputBoxOnlyState();
}

class _TextInputBoxOnlyState extends State<TextInputBoxOnly> {
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

class TextInputBox extends StatefulWidget {
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
    this.numberFormatter,
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
