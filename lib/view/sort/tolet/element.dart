import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:btolet/view/tolet/tolet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class SortButton extends StatefulWidget {
  final int type;
  const SortButton({super.key, required this.type});

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  List<String> categories = ['1', '2', '3', '4', '5', '6+'];
  List<bool> isSelected = [false, false, false, false, false, false];
  final ToletController toletController = Get.find();

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
              // shape: StadiumBorder(side: BorderSide()),
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
                      toletController.bedsort.add(categories[index]);
                    } else {
                      toletController.bedsort.remove(categories[index]);
                    }
                  } else {
                    if (selected) {
                      toletController.bathsort.add(categories[index]);
                    } else {
                      toletController.bathsort.remove(categories[index]);
                    }
                  }
                  toletController.sortingPostCount();
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

class CategoryChipSort extends StatelessWidget {
  final String category;
  final RxBool categoryState;

  const CategoryChipSort({
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
            toletController.sortingPostCount();
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

class FasalitisChipSort extends StatelessWidget {
  final String text;
  final RxBool categoryState;
  final IconData icon;

  const FasalitisChipSort({
    Key? key,
    required this.text,
    required this.icon,
    required this.categoryState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToletController toletController = Get.find();
    return Obx(
      () => FilterChip(
        showCheckmark: false,
        label: Text(text),
        selected: categoryState.value,
        onSelected: (value) {
          categoryState.value = !categoryState.value;
          toletController.sortingPostCount();
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

class SortPostList extends StatefulWidget {
  const SortPostList({super.key});

  @override
  State<SortPostList> createState() => SortPostListState();
}

class SortPostListState extends State<SortPostList> {
  ToletController toletController = Get.find();
  final scrollController = ScrollController();
  @override
  void initState() {
    toletController.sortedPostList();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("You're at the top.");
        } else {
          print("You're at the bottom.");
          toletController.sortedPostList();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    toletController.allSortedPost.clear();
    toletController.sortpage.value = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sorted Post'),
        centerTitle: false,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Feather.chevron_left),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                StreamBuilder(
                  stream: toletController.allSortedPost.stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const PostListSimmer(
                        topPadding: 20,
                        count: 10,
                      );
                    } else {
                      return ListView.builder(
                        // key: UniqueKey(),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length + 1,
                        itemBuilder: (c, i) {
                          if (i < snapshot.data.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: PostsTolet(
                                postData: snapshot.data[i],
                              ),
                            );
                          } else {
                            if (toletController.sortloding.value) {
                              return const PostListSimmer(
                                topPadding: 20,
                                count: 3,
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('nothing more to load!'),
                                ),
                              );
                            }
                          }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
