import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:btolet/view/post/pro%20widget/dropdown.dart';
import 'package:btolet/view/post/pro%20widget/fasalitis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import 'chips.dart';
import 'text_input.dart';

class CategoryBodyPro extends StatefulWidget {
  const CategoryBodyPro({super.key});

  @override
  State<CategoryBodyPro> createState() => _CategoryBodyProState();
}

class _CategoryBodyProState extends State<CategoryBodyPro> {
  ProController proController = Get.find();
  double space = 20.0;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (proController.selectedCategory.value == category[0] ||
          proController.selectedCategory.value == category[1]) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextInputPro(
              topPadding: 0,
              title: "Property Name",
              textType: TextInputType.text,
              hintText: "Modern Apartment",
              textlength: 500,
              suffixtext: "",
              controller: proController.name,
              widthh: 2.35 / 2,
              focusNode: proController.namefocusNode,
            ),
            PorChipsNotext(
              options: type,
              selected: proController.selectedType,
            ),
            PorChips(
              title: 'Bedroom *',
              options: bed,
              selected: proController.selectedRooms,
              icon: Icons.bed_outlined,
            ),
            PorChips(
              title: 'Bathroom *',
              options: bath,
              selected: proController.selectedBath,
              icon: Icons.bathtub_outlined,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 1,
                  child: DropDownPro(
                    title: "Dining *",
                    category: CategoryPro.dining,
                    widthh: 2.35,
                    topPadding: 20,
                  ),
                ),
                SizedBox(width: space),
                const Expanded(
                  flex: 1,
                  child: DropDownPro(
                    title: "Kitchen *",
                    category: CategoryPro.kitchen,
                    widthh: 2.35,
                    topPadding: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: space),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: DropDownPro(
                    title: "Facing *",
                    category: CategoryPro.facing,
                    widthh: 2.35,
                    topPadding: 0,
                  ),
                ),
                SizedBox(width: space),
                const Expanded(
                  flex: 1,
                  child: DateTimeSelectPro(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: TextInputPro(
                    topPadding: space,
                    title: "Total Floor *",
                    textType: TextInputType.number,
                    hintText: "12",
                    textlength: 2,
                    suffixtext: "",
                    controller: proController.totalFloor,
                    // numberFormatter: ThousandsFormatter(),
                    widthh: 2.35,
                    focusNode: proController.totalFloorfocusNode,
                  ),
                ),
                SizedBox(width: space),
                Expanded(
                  flex: 1,
                  child: TextInputPro(
                    topPadding: space,
                    title: "Floor Number *",
                    textType: TextInputType.number,
                    hintText: "5 th",
                    textlength: 2,
                    suffixtext: "th",
                    controller: proController.floorNumber,
                    // numberFormatter: ThousandsFormatter(),
                    widthh: 2.35,
                    focusNode: proController.floorNumberfocusNode,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: TextInputPro(
                    topPadding: space,
                    title: "Total Size *",
                    textType: TextInputType.text,
                    hintText: "12x12 or ft\u00b2",
                    textlength: 15,
                    suffixtext: "",
                    controller: proController.totalSize,
                    // numberFormatter: ThousandsFormatter(),
                    widthh: 2.35,
                    focusNode: proController.totalSizefocusNode,
                  ),
                ),
                SizedBox(width: space),
                Expanded(
                  flex: 1,
                  child: TextInputPro(
                    topPadding: space,
                    title: "Total Unit *",
                    textType: TextInputType.number,
                    hintText: "10",
                    textlength: 2,
                    suffixtext: "",
                    controller: proController.totalUnit,
                    // numberFormatter: ThousandsFormatter(),
                    widthh: 2.35,
                    focusNode: proController.totalUnitfocusNode,
                  ),
                ),
              ],
            ),
            PorChipsNotext(
              options: priceType,
              selected: proController.selectedPriceType,
            ),
            proController.selectedPriceType.value == priceType[0]
                ? TextInputPro(
                    topPadding: space,
                    title: "Price *",
                    textType: TextInputType.number,
                    hintText: "2,000,000 ৳",
                    textlength: 500,
                    suffixtext: "৳",
                    controller: proController.price,
                    numberFormatter: ThousandsFormatter(),
                    widthh: 1.2,
                    focusNode: proController.pricefocusNode,
                  )
                : const SizedBox(),
            SizedBox(height: space),
            const FacilitiesPro(),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PorChipsNotextMulti(
              options: landType,
              selected: proController.selectedLandTypes,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const DropDownPro(
                    title: "Area *",
                    category: CategoryPro.area,
                    widthh: 2.4,
                    topPadding: 20,
                  ),
                  SizedBox(width: space),
                  TextInputPro(
                    topPadding: space,
                    title: "Mesurement *",
                    textType: TextInputType.number,
                    hintText: "4.95",
                    textlength: 500,
                    suffixtext: "",
                    controller: proController.mesurement,
                    // numberFormatter: ThousandsFormatter(),
                    widthh: 2.4,
                    focusNode: proController.mesurementfocusNode,
                  ),
                ],
              ),
            ),
            TextInputPro(
              topPadding: space,
              title: "Road Size *",
              textType: TextInputType.number,
              hintText: "20m",
              textlength: 500,
              suffixtext: "m",
              controller: proController.roadSize,
              numberFormatter: ThousandsFormatter(),
              widthh: 1.2,
              focusNode: proController.roadSizefocusNode,
            ),
            PorChipsNotext(
              options: priceType,
              selected: proController.selectedPriceType,
            ),
            proController.selectedPriceType.value == priceType[0]
                ? TextInputPro(
                    topPadding: space,
                    title: "Price *",
                    textType: TextInputType.number,
                    hintText: "2,000,000 ৳",
                    textlength: 500,
                    suffixtext: "৳",
                    controller: proController.price,
                    numberFormatter: ThousandsFormatter(),
                    widthh: 1.2,
                    focusNode: proController.pricefocusNode,
                  )
                : const SizedBox(),
          ],
        );
      }
    });
  }
}
