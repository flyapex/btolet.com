import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  final RxBool categoryState;

  const CategoryChip({
    super.key,
    required this.category,
    required this.categoryState,
  });

  @override
  Widget build(BuildContext context) {
    ToletController toletController = Get.find();
    return Obx(
      () {
        return SizedBox(
          height: 45,
          child: FilterChip(
            showCheckmark: false,
            label: Text(
              category,
              style: TextStyle(
                height: 0.7,
                color: Colors.black.withOpacity(0.5),
                fontSize: s3,
              ),
            ),
            selected: categoryState.value,
            onSelected: (value) {
              categoryState.value = !categoryState.value;
              if (toletController.categories.values
                  .where((value) => value.value)
                  .isNotEmpty) {
                toletController.categoryFlag.value = true;
              } else {
                toletController.categoryFlag.value = false;
              }

              var t = toletController;
              if (t.categoryFlag.value) {
              } else {
                t.checkAllCatagory();
              }
            },
            avatar: Icon(
              categoryState.value ? Icons.check_circle_rounded : Icons.add,
              color: categoryState.value
                  ? const Color(0xff0166EE)
                  : const Color.fromARGB(255, 192, 194, 198),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200.0)),
            side: BorderSide(
              color: toletController.activeFlag.value
                  ? toletController.categoryFlag.value
                      ? Colors.black.withOpacity(0.1)
                      : Colors.red
                  : categoryState.value
                      ? const Color(0xff0166EE)
                      : Colors.black.withOpacity(0.1),
            ),
            elevation: 0.3,
            selectedShadowColor: Colors.black.withOpacity(0.5),
            shadowColor: Colors.black.withOpacity(0.5),
            backgroundColor: Colors.white,
            selectedColor: Colors.white,
          ),
        );
      },
    );
  }
}

class FasalitisChip extends StatelessWidget {
  final String text;
  final RxBool categoryState;
  final IconData icon;

  const FasalitisChip({
    Key? key,
    required this.text,
    required this.icon,
    required this.categoryState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 50,
        child: FilterChip(
          showCheckmark: false,
          label: Text(text, style: h3),
          selected: categoryState.value,
          onSelected: (value) {
            categoryState.value = !categoryState.value;
          },
          avatar: Icon(
            icon,
            color: categoryState.value
                ? const Color(0xff0166EE)
                : const Color.fromARGB(255, 192, 194, 198),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          side: BorderSide(
            color: categoryState.value
                ? const Color(0xff0166EE)
                : Colors.black.withOpacity(0.1),
          ),
          elevation: 0.3,
          selectedShadowColor: Colors.black.withOpacity(0.5),
          shadowColor: Colors.black.withOpacity(0.5),
          backgroundColor: Colors.white,
          selectedColor: Colors.white,
        ),
      ),
    );
  }
}

class ToletChips extends StatelessWidget {
  final String title;
  final List<String> options;
  final RxString selected;
  const ToletChips({
    super.key,
    required this.options,
    required this.selected,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    getBorderColor() {
      return Colors.black12;
    }

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              letterSpacing: 0.7,
              color: Colors.black.withOpacity(0.5),
              fontSize: s3,
              // height: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    backgroundColor: Colors.white,
                    selectedColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(300),
                      side: BorderSide(
                        color: selected.value == option
                            ? const Color(0xff0166EE)
                            : getBorderColor(),
                        width: 1,
                      ),
                    ),
                    checkmarkColor: const Color(0xff0166EE),
                    label: Text(
                      option,
                      style: h3,
                    ),
                    selected: selected.value == option,
                    onSelected: (isSelected) {
                      if (isSelected) {
                        selected.value = option;
                      }

                      // if (options == priceType) {
                      //   proController.priceFlag.value =
                      //       proController.price.text.isNotEmpty ||
                      //           proController.selectedPriceType.value !=
                      //               priceType[0];
                      // }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
