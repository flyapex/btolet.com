import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
    fontSize: s3,
    letterSpacing: 1.2,
  );
  var textstyleh = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: s3,
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
            fontSize: s3,
          ),
          overflow: TextOverflow.ellipsis,
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
              Expanded(
                child: SizedBox(
                  height: 48,
                  // width: (Get.width / widget.widthh),
                  child: Focus(
                    onFocusChange: (val) {
                      setState(() {
                        val ? iconColorChange = true : iconColorChange = false;
                      });
                    },
                    child: IntrinsicWidth(
                      child: Center(
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
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.all(10),
                            suffix: Text(
                              widget.suffixtext,
                              style: TextStyle(
                                color: iconColorChange
                                    ? const Color(0xff0166EE)
                                    : Colors.amber,
                                fontSize: widget.suffixtext == '৳' ? 15 : s3,
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

class DateTimeSelect extends StatefulWidget {
  const DateTimeSelect({super.key});

  @override
  State<DateTimeSelect> createState() => _DateTimeSelectState();
}

class _DateTimeSelectState extends State<DateTimeSelect> {
  ToletController toletController = Get.find();
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
                        print(val);
                        toletController.rentFrom = val;
                        setState(() {
                          _chosenDateTime = val;
                          toletController.rentFrom = val;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rent From',
          style: TextStyle(
            letterSpacing: 0.7,
            color: Colors.black.withOpacity(0.5),
            fontSize: s3,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 46,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, double.infinity),
              backgroundColor: const Color(0xffF2F3F5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () {
              _showDatePicker(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _chosenDateTime == null
                    ? Text(
                        DateFormat().add_MMMd().format(DateTime.now()),
                        style: h3,
                      )
                    : Text(
                        DateFormat().add_MMMd().format(_chosenDateTime!),
                        style: const TextStyle(
                          fontSize: s3,
                          color: Colors.black,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
