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
        return FilterChip(
          showCheckmark: false,
          label: Text(
            category,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
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

            // toletController.activeFlag(false);
            // toletController.categoryFlag.value = false;
            // toletController.bedFlag(false);
            // toletController.bathFlag(false);
            // toletController.kitchenFlag(false);
            // toletController.priceFlag(false);
            // toletController.imageFlag(false);
            // toletController.floorFlag(false);
            // toletController.phoneFlag(false);
          },
          avatar: Icon(
            categoryState.value ? Icons.check_circle_rounded : Icons.add,
            color: categoryState.value
                ? const Color(0xff0166EE)
                : const Color.fromARGB(255, 192, 194, 198),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
      () => FilterChip(
        showCheckmark: false,
        label: Text(text),
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
    );
  }
}
