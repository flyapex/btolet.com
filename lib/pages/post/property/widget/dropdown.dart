import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/model/postmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class DragdownBoxPropertyPage extends StatefulWidget {
  final String title;
  final double topPadding;
  final List catagoryName;
  final double widthh;
  const DragdownBoxPropertyPage({
    super.key,
    required this.title,
    this.topPadding = 10.0,
    required this.catagoryName,
    required this.widthh,
  });

  @override
  State<DragdownBoxPropertyPage> createState() =>
      _DragdownBoxPropertyPageState();
}

class _DragdownBoxPropertyPageState extends State<DragdownBoxPropertyPage> {
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
    if (widget.catagoryName == diningProperty) {
      return postController.diningProperty.value;
    } else if (widget.catagoryName == facingProperty) {
      return postController.facingProperty.value;
    } else if (widget.catagoryName == kitchenProperty) {
      return postController.kitchenProperty.value;
    } else if (widget.catagoryName == area) {
      return postController.area.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    getTextList() {
      if (widget.catagoryName == diningProperty) {
        return diningProperty;
      } else if (widget.catagoryName == facingProperty) {
        return facingProperty;
      } else if (widget.catagoryName == kitchenProperty) {
        return kitchenProperty;
      } else if (widget.catagoryName == area) {
        return area;
      }
      //  else if (widget.catagoryName == facing) {
      //   return facing;
      // } else if (widget.catagoryName == kitchen) {
      //   return kitchen;
      // }
    }

    getBorderColor() {
      if (widget.catagoryName == diningProperty) {
        return postController.flagActiveFlagProperty.value
            ? postController.dingngFlagProperty.value
                ? Colors.white
                : Colors.red
            : Colors.white;
      } else if (widget.catagoryName == facingProperty) {
        return postController.flagActiveFlagProperty.value
            ? postController.facingFlagProperty.value
                ? Colors.white
                : Colors.red
            : Colors.white;
      } else if (widget.catagoryName == kitchenProperty) {
        return postController.flagActiveFlagProperty.value
            ? postController.kitchenFlagProperty.value
                ? Colors.white
                : Colors.red
            : Colors.white;
      } else if (widget.catagoryName == area) {
        return postController.flagActiveFlagProperty.value
            ? postController.areaFlagProperty.value
                ? Colors.white
                : Colors.red
            : Colors.white;
      } else {
        return Colors.white;
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
                            if (widget.catagoryName == diningProperty) {
                              postController.diningProperty.value =
                                  val.toString();
                            } else if (widget.catagoryName == facingProperty) {
                              postController.facingProperty.value =
                                  val.toString();
                            } else if (widget.catagoryName == kitchenProperty) {
                              postController.kitchenProperty.value =
                                  val.toString();
                            } else if (widget.catagoryName == area) {
                              postController.area.value = val.toString();
                            }

                            postController.allToletFlagCheckProperty();
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
