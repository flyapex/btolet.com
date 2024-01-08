import 'package:btolet/controller/property_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryChipPro extends StatelessWidget {
  final String category;
  final RxBool categoryState;

  const CategoryChipPro({
    super.key,
    required this.category,
    required this.categoryState,
  });

  @override
  Widget build(BuildContext context) {
    ProController proController = Get.find();
    return Obx(
      () {
        return FilterChip(
          showCheckmark: false,
          label: Text(
            category,
            // style: TextStyle(
            //   color: Colors.black.withOpacity(0.5),
            // ),
          ),
          selected: categoryState.value,
          onSelected: (value) {
            categoryState.value = !categoryState.value;
            proController.sortingPostCount();
          },
          avatar: Icon(
            categoryState.value ? Icons.check_circle_rounded : Icons.circle,
            color:
                categoryState.value ? const Color(0xff0166EE) : Colors.black12,
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
        );
      },
    );
  }
}

class FasalitisChipProSort extends StatelessWidget {
  final String text;
  final RxBool categoryState;
  final IconData icon;

  const FasalitisChipProSort({
    Key? key,
    required this.text,
    required this.icon,
    required this.categoryState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProController proController = Get.find();
    return Obx(
      () => FilterChip(
        showCheckmark: false,
        label: Text(text),
        selected: categoryState.value,
        onSelected: (value) {
          categoryState.value = !categoryState.value;
          proController.getFasalitiesSort();
          proController.sortingPostCount();
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

class SortButtonPro extends StatefulWidget {
  final int type;
  const SortButtonPro({super.key, required this.type});

  @override
  State<SortButtonPro> createState() => _SortButtonProState();
}

class _SortButtonProState extends State<SortButtonPro> {
  List<String> categories = ['1', '2', '3', '4', '5', '6+'];
  List<bool> isSelected = [false, false, false, false, false, false];
  final ProController proController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.black,
      ),
      child: SizedBox(
        height: 40,
        width: Get.width,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return FilterChip(
              showCheckmark: false,
              shape: const StadiumBorder(side: BorderSide()),
              // padding: const EdgeInsets.only(left: 5, right: 5),

              // labelPadding: const EdgeInsets.only(right: 5, left: 5),
              label: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected[index]
                      ? const Color(0xff0166EE)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
              selected: isSelected[index],
              onSelected: (bool selected) {
                setState(() {
                  isSelected[index] = selected;
                  if (widget.type == 1) {
                    if (selected) {
                      proController.bedSort.add(categories[index]);
                    } else {
                      proController.bedSort.remove(categories[index]);
                    }
                  } else {
                    if (selected) {
                      proController.bathSort.add(categories[index]);
                    } else {
                      proController.bathSort.remove(categories[index]);
                    }
                  }
                  proController.sortingPostCount();
                });
              },
              avatar: Icon(
                isSelected[index] ? Icons.check_circle_rounded : Icons.add,
                // Icons.check_circle_rounded,
                color: isSelected[index]
                    ? const Color(0xff0166EE)
                    : const Color.fromARGB(255, 192, 194, 198),
              ),
              elevation: 0.3,
              side: BorderSide(
                color: isSelected[index]
                    ? const Color(0xff0166EE)
                    : Colors.black.withOpacity(0.1),
              ),
              selectedShadowColor: Colors.black.withOpacity(0.5),
              shadowColor: Colors.black.withOpacity(0.5),
              backgroundColor: Colors.white,
              selectedColor: Colors.white,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 10);
          },
        ),
      ),
    );
  }
}
