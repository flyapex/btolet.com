import 'package:flutter/material.dart';
import 'package:btolet/controller/post_controller.dart';
import 'package:get/get.dart';

class PorpertyChips extends StatefulWidget {
  final RxList<String> categorylist;
  final String title;

  const PorpertyChips({
    Key? key,
    required this.categorylist,
    required this.title,
  }) : super(key: key);

  @override
  State<PorpertyChips> createState() => _PorpertyChipsState();
}

class _PorpertyChipsState extends State<PorpertyChips> {
  PostController postController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Center(
              child: Wrap(
                spacing: 8.0,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 8.0,
                        children: List.generate(
                          postController.category.length,
                          (index) => ChoiceChip(
                            label: Text(postController.category[index]),
                            selected: postController.selectedCategory.value ==
                                postController.category[index],
                            onSelected: (selected) {
                              postController.selectCategory(
                                  postController.category[index]);
                              print(postController.selectedCategory.value);

                              if (index == 0 || index == 1) {
                                postController.iscategory.value = true;
                              } else {
                                postController.iscategory.value = false;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChipsType extends StatelessWidget {
  const ChipsType({super.key});

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Column(
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Wrap(
                    spacing: 8.0,
                    children: postController.type.map((value) {
                      return ChoiceChip(
                        label: Text(value),
                        selected: postController.type.indexOf(value) ==
                            postController.typeSelected.value,
                        onSelected: (selected) {
                          postController.typeSelected.value = selected
                              ? postController.type.indexOf(value)
                              : postController.typeSelected.value;
                          print(postController
                              .type[postController.typeSelected.value]);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChipsLandType extends StatelessWidget {
  const ChipsLandType({super.key});

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Column(
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Wrap(
                    spacing: 8.0,
                    children:
                        postController.landType.asMap().entries.map((entry) {
                      int index = entry.key;
                      String value = entry.value;
                      return ChoiceChip(
                        label: Text(value),
                        selected:
                            postController.selectedLandTypes.contains(index),
                        onSelected: (selected) {
                          if (selected) {
                            postController.selectedLandTypes.add(index);
                          } else {
                            if (postController.selectedLandTypes.length > 1) {
                              postController.selectedLandTypes.remove(index);
                            }
                          }
                          print(postController.selectedLandTypes
                              .map((index) => postController.landType[index]));
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChipsPostedBy extends StatelessWidget {
  const ChipsPostedBy({super.key});

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Column(
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Wrap(
                    spacing: 8.0,
                    children: postController.postedBy.map((value) {
                      return ChoiceChip(
                        label: Text(value),
                        selected: postController.postedBy.indexOf(value) ==
                            postController.postedBySelected.value,
                        onSelected: (selected) {
                          postController.postedBySelected.value = selected
                              ? postController.postedBy.indexOf(value)
                              : postController.postedBySelected.value;
                          print(postController
                              .postedBy[postController.postedBySelected.value]);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChipsRooms extends StatelessWidget {
  final String title;
  final IconData icon;
  const ChipsRooms({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Center(
              child: Wrap(
                spacing: 8.0,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(icon),
                          const SizedBox(width: 10),
                          Text(title),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 8.0,
                        children: postController.propertyRooms.map((value) {
                          return ChoiceChip(
                            label: Text(value),
                            selected:
                                postController.propertyRooms.indexOf(value) ==
                                    postController.propertyRoomsSelected.value,
                            onSelected: (selected) {
                              postController.propertyRoomsSelected.value =
                                  selected
                                      ? postController.propertyRooms
                                          .indexOf(value)
                                      : postController
                                          .propertyRoomsSelected.value;
                              print(postController.propertyRooms[
                                  postController.propertyRoomsSelected.value]);
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChipsBath extends StatelessWidget {
  final String title;
  final IconData icon;
  const ChipsBath({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Center(
              child: Wrap(
                spacing: 8.0,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(icon),
                          const SizedBox(width: 10),
                          Text(title),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 8.0,
                        children: postController.propertyBath.map((value) {
                          return ChoiceChip(
                            label: Text(value),
                            selected:
                                postController.propertyBath.indexOf(value) ==
                                    postController.propertyBathSelected.value,
                            onSelected: (selected) {
                              postController.propertyBathSelected.value =
                                  selected
                                      ? postController.propertyBath
                                          .indexOf(value)
                                      : postController
                                          .propertyBathSelected.value;
                              print(postController.propertyBath[
                                  postController.propertyBathSelected.value]);
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PorpertyChipsWithIcon extends StatefulWidget {
  final RxList<String> categorylist;
  final String title;
  final IconData icon;
  const PorpertyChipsWithIcon({
    super.key,
    required this.categorylist,
    required this.title,
    required this.icon,
  });

  @override
  State<PorpertyChipsWithIcon> createState() => _PorpertyChipsWithIconState();
}

class _PorpertyChipsWithIconState extends State<PorpertyChipsWithIcon> {
  PostController postController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Center(
              child: Wrap(
                spacing: 8.0,
                children: [
                  _buildChips(widget.categorylist, widget.title),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChips(RxList<String> list, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          children: [
            Icon(widget.icon),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 8.0,
          children: List.generate(
            list.length,
            (index) => ChoiceChip(
              label: Text(list[index]),
              selected: postController.selectedCategory.value == list[index],
              onSelected: (selected) {
                // postController.selectCategory(list[index]);
                print(postController.selectedCategory.value);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class FasalitisPropertyChip extends StatelessWidget {
  final String text;
  final RxBool categoryState;
  final IconData icon;

  const FasalitisPropertyChip({
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
