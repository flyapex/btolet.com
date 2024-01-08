import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    final List<String> categoryValues = categoryProData[widget.category] ?? [];
    getBorderColor() {
      if (widget.category == CategoryPro.dining) {
        return proController.activeFlag.value
            ? proController.diningFlag.value
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
                          proController.getCategoryValue(widget.category),
                          style:
                              proController.getCategoryValue(widget.category) ==
                                      'select'
                                  ? textstyleh
                                  : textstylemain,
                        ),
                        items: categoryValues.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
              ],
            ),
          ),
        ],
      );
    });
  }
}
