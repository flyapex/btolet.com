import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class DropDown extends StatefulWidget {
  final String title;
  final double topPadding;
  final Category category;
  // final double widthh;

  const DropDown({
    super.key,
    required this.title,
    this.topPadding = 10.0,
    required this.category,
    // required this.widthh,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final ToletController toletController = Get.find();

  var textstylemain = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: s3,
    letterSpacing: 1.2,
    color: Colors.black.withOpacity(0.7),
  );
  var textstyleh = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: s3,
    letterSpacing: 1.2,
    color: Colors.black.withOpacity(0.6),
  );

  @override
  Widget build(BuildContext context) {
    final List<String> categoryValues = categoryData[widget.category] ?? [];
    getBorderColor() {
      return Colors.white;
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
                      toletController.getCategoryValue(widget.category),
                      style:
                          toletController.getCategoryValue(widget.category) ==
                                  'select'
                              ? textstyleh
                              : textstylemain,
                    ),
                    items: categoryValues.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: h3,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      toletController.setCategoryValue(
                          widget.category, val.toString());

                      toletController.flagCheck();
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
