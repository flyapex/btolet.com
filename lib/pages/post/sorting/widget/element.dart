import 'package:btolet/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryToletChipSortTolet extends StatelessWidget {
  final String category;
  final RxBool categoryState;

  const CategoryToletChipSortTolet({
    super.key,
    required this.category,
    required this.categoryState,
  });

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
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
            postController.sortingPostCount();
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
            color: postController.flagActiveFlag.value
                ? postController.categoryFlag.value
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

class FasalitisSortTolet extends StatelessWidget {
  final String text;
  final RxBool categoryState;
  final IconData icon;

  const FasalitisSortTolet({
    Key? key,
    required this.text,
    required this.icon,
    required this.categoryState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
    return Obx(
      () => FilterChip(
        showCheckmark: false,
        label: Text(text),
        selected: categoryState.value,
        onSelected: (value) {
          categoryState.value = !categoryState.value;
          postController.sortingPostCount();
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

class SortButton extends StatefulWidget {
  final int type;
  const SortButton({super.key, required this.type});

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  List<String> categories = ['1', '2', '3', '4', '5', '6+'];
  List<bool> isSelected = [false, false, false, false, false, false];
  final PostController postController = Get.find();

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
              // padding: const EdgeInsets.only(left: 5, right: 5),
              labelPadding: const EdgeInsets.only(right: 5, left: 5),
              label: Text(
                categories[index],
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              selected: isSelected[index],
              onSelected: (bool selected) {
                setState(() {
                  isSelected[index] = selected;
                  if (widget.type == 1) {
                    if (selected) {
                      postController.bedsort.add(categories[index]);
                    } else {
                      postController.bedsort.remove(categories[index]);
                    }
                  } else {
                    if (selected) {
                      postController.bathsort.add(categories[index]);
                    } else {
                      postController.bathsort.remove(categories[index]);
                    }
                  }
                  postController.sortingPostCount();
                });
              },
              avatar: Icon(
                isSelected[index] ? Icons.check_circle_rounded : Icons.add,
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
