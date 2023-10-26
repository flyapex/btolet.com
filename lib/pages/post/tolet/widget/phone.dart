import 'package:btolet/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NumberBoxTolet extends StatefulWidget {
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

  const NumberBoxTolet({
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
  State<NumberBoxTolet> createState() => _NumberBoxToletState();
}

class _NumberBoxToletState extends State<NumberBoxTolet> {
  final PostController postController = Get.find();

  static const TextStyle textstyle = TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    fontSize: 16,
    letterSpacing: 1.2,
  );

  static const TextStyle textstyleh = TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    fontSize: 15,
    letterSpacing: 1.2,
  );

  var hinttex = '017xxxxxxxx';
  var iconColorChange = false;

  getBorderColor() {
    final phoneFlag = postController.phoneFlag.value;
    return postController.flagActiveFlag.value
        ? phoneFlag
            ? Colors.white
            : Colors.red
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
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
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F3F5),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: getBorderColor()),
                    ),
                    child: Stack(
                      children: [
                        if (widget.hintText == '')
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                hinttex,
                                style: textstyleh,
                              ),
                            ),
                          ),
                        Focus(
                          onFocusChange: (v) {
                            if (widget.hintText == '') {
                              hinttex = '';
                            }
                          },
                          child: TextField(
                            autofillHints: const [
                              AutofillHints.telephoneNumber,
                            ],
                            onChanged: (val) {
                              // postController.allToletFlagCheck();
                            },
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
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(6),
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
      ),
    );
  }
}
