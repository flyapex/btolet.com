import 'package:btolet/api/google_api.dart';
import 'package:btolet/model/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PorCategoryChips extends StatelessWidget {
  final String title;
  final List<String> options;
  final RxString selected;
  const PorCategoryChips({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 15),
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
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: selected.value == option
                            ? const Color(0xff0166EE)
                            : Colors.black12,
                        width: 1,
                      ),
                    ),
                    avatar: Icon(
                      selected.value == option
                          ? Icons.check_circle_rounded
                          : Icons.circle,
                      color: selected.value == option
                          ? const Color(0xff0166EE)
                          : Colors.black12,
                    ),
                    checkmarkColor: const Color(0xff0166EE),
                    showCheckmark: false,
                    label: Text(option),
                    selected: selected.value == option,
                    onSelected: (isSelected) {
                      if (isSelected) {
                        selected.value = option;
                      }
                      var c = proController.selectedCategory.value;
                      var t = proController;
                      if (c == category[0] || c == category[1]) {
                        t.mesurementFlag(true);
                        t.rodeSizeFlag(true);
                      } else {
                        t.diningFlag(true);
                        t.kitchenFlag(true);
                        t.facingFlag(true);
                        t.totalfloorFlag(true);
                        t.floornumberFlag(true);
                        t.totalsizeFlag(true);
                        t.totalUnitFlag(true);
                      }
                      print("object");
                      t.checkAllCatagory();
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

class PorChipsNotext extends StatelessWidget {
  final List<String> options;
  final RxString selected;
  const PorChipsNotext({
    super.key,
    required this.options,
    required this.selected,
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
          const SizedBox(height: 15),
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
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: selected.value == option
                            ? const Color(0xff0166EE)
                            : getBorderColor(),
                        width: 1,
                      ),
                    ),
                    checkmarkColor: const Color(0xff0166EE),
                    label: Text(option),
                    selected: selected.value == option,
                    onSelected: (isSelected) {
                      if (isSelected) {
                        selected.value = option;
                      }
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

class PorChipsNotextMulti extends StatelessWidget {
  final List<String> options;
  final RxList selected;

  const PorChipsNotextMulti({
    super.key,
    required this.options,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    // ProController proController = Get.find();
    getBorderColor() {
      return Colors.black12;
    }

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: options.map((option) {
                final isSelected = selected.contains(option);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    backgroundColor: Colors.white,
                    selectedColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xff0166EE)
                            : getBorderColor(),
                        width: 1,
                      ),
                    ),
                    checkmarkColor: const Color(0xff0166EE),
                    label: Text(option),
                    selected: isSelected,
                    onSelected: (isSelected) {
                      if (isSelected || selected.length > 1) {
                        if (isSelected) {
                          selected.add(option);
                        } else {
                          if (selected.length > 1) {
                            selected.remove(option);
                          }
                        }
                      }
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

class PorChips extends StatelessWidget {
  final String title;
  final List<String> options;
  final RxString selected;
  final IconData icon;
  const PorChips({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              Icon(
                icon,
                color: Colors.black54,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
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
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: selected.value == option
                            ? const Color(0xff0166EE)
                            : Colors.black12,
                        width: 1,
                      ),
                    ),
                    checkmarkColor: const Color(0xff0166EE),
                    label: Text(
                      option,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    selected: selected.value == option,
                    onSelected: (isSelected) {
                      if (isSelected) {
                        selected.value = option;
                      }
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

class FasalitisChipPro extends StatelessWidget {
  final String text;
  final RxBool categoryState;
  final IconData icon;

  const FasalitisChipPro({
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
          proController.getFasalitiesSort();
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

// import 'package:btolet/controller/property_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PorChips extends StatefulWidget {
//   final RxList<String> categorylist;
//   final String title;

//   const PorChips({
//     Key? key,
//     required this.categorylist,
//     required this.title,
//   }) : super(key: key);

//   @override
//   State<PorChips> createState() => _PorChipsState();
// }

// class _PorChipsState extends State<PorChips> {
//   ProController proController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             Center(
//               child: Wrap(
//                 spacing: 8.0,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.title,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black.withOpacity(0.5),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       Wrap(
//                         spacing: 8.0,
//                         children: List.generate(
//                           proController.category.length,
//                           (index) => ChoiceChip(
//                             backgroundColor: Colors.white,
//                             selectedColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               side: BorderSide(
//                                 color: proController.selectedCategory.value ==
//                                         proController.category[index]
//                                     ? const Color(0xff0166EE)
//                                     : Colors.black12,
//                                 width: 1,
//                               ),
//                             ),
//                             showCheckmark: false,
//                             avatar: Icon(
//                               proController.selectedCategory.value ==
//                                       proController.category[index]
//                                   ? Icons.check_circle_rounded
//                                   : Icons.circle,
//                               color: proController.selectedCategory.value ==
//                                       proController.category[index]
//                                   ? const Color(0xff0166EE)
//                                   : Colors.black12,
//                             ),
//                             checkmarkColor: const Color(0xff0166EE),
//                             label: Text(proController.category[index]),
//                             selected: proController.selectedCategory.value ==
//                                 proController.category[index],
//                             onSelected: (selected) {
//                               proController.selectCategory(
//                                   proController.category[index]);
//                               print(proController.selectedCategory.value);

//                               if (index == 0 || index == 1) {
//                                 proController.iscategory.value = true;
//                               } else {
//                                 proController.iscategory.value = false;
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
