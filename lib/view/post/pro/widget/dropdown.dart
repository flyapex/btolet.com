import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DropDownPro extends StatefulWidget {
  final String title;
  final double topPadding;
  final CategoryPro category;
  final double widthh;

  const DropDownPro({
    super.key,
    required this.title,
    this.topPadding = 10.0,
    required this.category,
    required this.widthh,
  });

  @override
  State<DropDownPro> createState() => _DropDownProState();
}

class _DropDownProState extends State<DropDownPro> {
  final ProController proController = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<String> categoryValues = categoryProData[widget.category] ?? [];
    getBorderColor() {
      if (widget.category == CategoryPro.balcony) {
        return proController.activeFlag.value
            ? proController.balconyFlag.value
                ? Colors.white
                : Colors.red
            : Colors.white;
      } else if (widget.category == CategoryPro.kitchen) {
        return proController.activeFlag.value
            ? proController.kitchenFlag.value
                ? Colors.white
                : Colors.red
            : Colors.white;
      } else if (widget.category == CategoryPro.facing) {
        return proController.activeFlag.value
            ? proController.facingFlag.value
                ? Colors.white
                : Colors.red
            : Colors.white;
      }
      // else if (widget.category == CategoryPro.area) {
      //   return proController.activeFlag.value
      //       ? proController.areaFlag.value
      //           ? Colors.white
      //           : Colors.red
      //       : Colors.white;
      // }
      else {
        return Colors.white;
      }
    }

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: widget.topPadding)),
          Text(
            widget.title,
            style: TextStyle(
              letterSpacing: 0.7,
              color: Colors.black.withOpacity(0.5),
              fontSize: s3,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffF2F3F5),
              border: Border.all(
                color: getBorderColor(),
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: SizedBox(
              height: 48,
              // width: (Get.width / widget.widthh),
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
                      proController.getCategoryValue(widget.category),
                      style: widget.category == CategoryPro.area
                          ? const TextStyle(
                              fontFamily: 'Roboto',
                            )
                          : TextStyle(
                              overflow: TextOverflow.ellipsis,
                              height: 1.2,
                              fontSize: s3,
                              color: Colors.black.withOpacity(0.7),
                            ),
                    ).paddingOnly(bottom: 2),
                    items: categoryValues.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: widget.category == CategoryPro.area
                              ? TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black.withOpacity(0.6),
                                )
                              : h3,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      proController.setCategoryValue(
                          widget.category, val.toString());

                      proController.flagCheck();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class DateTimeSelectPro extends StatefulWidget {
  const DateTimeSelectPro({super.key});

  @override
  State<DateTimeSelectPro> createState() => _DateTimeSelectProState();
}

class _DateTimeSelectProState extends State<DateTimeSelectPro> {
  ProController proController = Get.find();
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
                        proController.sellFrom = val;
                        setState(() {
                          _chosenDateTime = val;
                          proController.sellFrom = val;
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
          'Sell From',
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
                        DateFormat().add_MMMd().format(
                              DateTime.now(),
                            ),
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
