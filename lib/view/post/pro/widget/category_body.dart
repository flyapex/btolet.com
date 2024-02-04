import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import 'chips.dart';
import 'dropdown.dart';
import 'fasalitis.dart';
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
            PorChips(
              title: 'Drawing  *',
              options: bed,
              selected: proController.selectedDrawing,
              icon: Icons.chair_outlined,
            ),
            PorChips(
              title: 'Dining *',
              options: bath,
              selected: proController.selectedDining,
              icon: Icons.table_restaurant_outlined,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 1,
                  child: DropDownPro(
                    title: "Balcony *",
                    category: CategoryPro.balcony,
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
                    textType: TextInputType.number,
                    hintText: "2500 ft\u00b2",
                    textlength: 5,
                    suffixtext: "ft\u00b2",
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
            const SizedBox(height: 20),
            PorChipsNotext(
              options: priceType,
              selected: proController.selectedPriceType,
            ),
            proController.selectedPriceType.value == priceType[0]
                ? TextInputPro(
                    topPadding: 10,
                    title: "Price *",
                    textType: TextInputType.number,
                    hintText: "2,000,000",
                    textlength: 500,
                    suffixtext: "৳",
                    controller: proController.price,
                    numberFormatter: ThousandsFormatter(),
                    widthh: 1.2,
                    focusNode: proController.pricefocusNode,
                  )
                : const SizedBox(),
            SizedBox(height: space),
            Text(
              'EMI',
              style: TextStyle(
                letterSpacing: 0.7,
                color: Colors.black.withOpacity(0.6),
                fontSize: s3,
                height: 1,
              ),
            ).paddingOnly(bottom: 2),
            PorChipsNotext(
              options: emi,
              selected: proController.selectedEMIType,
            ),
            SizedBox(height: space),
            const FacilitiesPro(),
            SizedBox(height: space),
          ],
        );
      } else {
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
            PorChipsNotextMulti(
              options: landType,
              selected: proController.selectedLandTypes,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 1,
                  child: DropDownPro(
                    title: "Area *",
                    category: CategoryPro.area,
                    widthh: 2.4,
                    topPadding: 20,
                  ),
                ),
                SizedBox(width: space),
                Expanded(
                  flex: 1,
                  child: TextInputPro(
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
                ),
              ],
            ),
            TextInputPro(
              topPadding: space,
              title: "Road Size *",
              textType: TextInputType.number,
              hintText: "20 feet",
              textlength: 500,
              suffixtext: "f",
              controller: proController.roadSize,
              numberFormatter: ThousandsFormatter(),
              widthh: 1.2,
              focusNode: proController.roadSizefocusNode,
            ),
            const SizedBox(height: 20),
            PorChipsNotext(
              options: priceType,
              selected: proController.selectedPriceType,
            ),
            proController.selectedPriceType.value == priceType[0]
                ? TextInputPro(
                    topPadding: 10,
                    title: "Price *",
                    textType: TextInputType.number,
                    hintText: "2,000,000",
                    textlength: 500,
                    suffixtext: "৳",
                    controller: proController.price,
                    numberFormatter: ThousandsFormatter(),
                    widthh: 1.2,
                    focusNode: proController.pricefocusNode,
                  )
                : const SizedBox(),
            // SizedBox(height: space),
          ],
        );
      }
    });
  }
}
