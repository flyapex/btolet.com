import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:btolet/view/tolet/tolet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        fontSize: s4,
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
                  fontSize: s3,
                  height: 0.5,
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
            ).paddingOnly(bottom: 2),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
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
        label: Text(text, style: h3),
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
          padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
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
                                count: 10,
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

class TextInputToletSort extends StatefulWidget {
  final String title;
  final int textlength;
  final String hintText;
  final String suffixtext;
  final TextInputType textType;
  final double topPadding;
  final TextEditingController controller;
  final TextInputFormatter? numberFormatter;
  final double widthh;
  final FocusNode focusNode;
  const TextInputToletSort({
    super.key,
    required this.title,
    required this.hintText,
    required this.textType,
    this.topPadding = 10,
    required this.controller,
    required this.suffixtext,
    required this.textlength,
    required this.widthh,
    this.numberFormatter,
    required this.focusNode,
  });

  @override
  State<TextInputToletSort> createState() => _TextInputToletSortState();
}

class _TextInputToletSortState extends State<TextInputToletSort> {
  ToletController toletController = Get.find();
  UserController userController = Get.find();
  var textstyle = TextStyle(
    overflow: TextOverflow.ellipsis,
    color: Colors.black.withOpacity(0.5),
    height: 1.2,
    fontSize: s3,
    letterSpacing: 1.2,
  );
  var textstyleh = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: s3,
    letterSpacing: 1.2,
    color: Colors.black.withOpacity(0.5),
  );
  var iconColorChange = false;
  getBorderColor() {
    return Colors.white;
  }

  getFocus() {
    final focusNodeMap = {
      toletController.priceminfocusNode: toletController.pricemaxfocusNode,
    };

    final nextFocusNode = focusNodeMap[widget.focusNode];

    if (nextFocusNode != null) {
      FocusScope.of(context).requestFocus(nextFocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.topPadding),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: s3,
            height: 0.7,
            letterSpacing: 0.7,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffF2F3F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: getBorderColor(),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  // width: (Get.width / widget.widthh),
                  child: Focus(
                    onFocusChange: (val) {
                      // if (val) {
                      //   if (toletController.pricemin == widget.controller) {
                      //     toletController.pricemin.text =
                      //         toletController.rentmin.value.toString();
                      //   } else if (toletController.pricemax ==
                      //       widget.controller) {
                      //     toletController.pricemax.text =
                      //         toletController.rentmax.value.toString();
                      //   }
                      // }
                      setState(() {
                        val ? iconColorChange = true : iconColorChange = false;
                      });
                    },
                    child: IntrinsicWidth(
                      child: TextField(
                        focusNode: widget.focusNode,
                        // inputFormatters: [
                        //   LengthLimitingTextInputFormatter(widget.titlelenth),
                        // ],

                        // inputFormatters: [ThousandsFormatter()],
                        inputFormatters: [
                          if (widget.numberFormatter != null)
                            widget.numberFormatter!,
                        ],
                        maxLength: widget.textlength,
                        cursorHeight: 24,
                        cursorWidth: 1.8,
                        cursorRadius: const Radius.circular(10),
                        controller: widget.controller,
                        textInputAction: TextInputAction.done,
                        keyboardType: widget.textType,
                        maxLines: 1,
                        cursorColor: Colors.black,
                        style: textstyle,
                        decoration: InputDecoration(
                          counterText: '',
                          suffix: Text(
                            widget.suffixtext,
                            style: TextStyle(
                              color: iconColorChange
                                  ? const Color(0xff0166EE)
                                  : Colors.amber,
                              fontSize: widget.suffixtext == '৳' ? 15 : s3,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                          hintText: widget.hintText,
                          hintStyle: textstyleh,
                        ),
                        onChanged: (val) {
                          if (toletController.pricemin == widget.controller) {
                            toletController.rentmin.value = val as int;
                          } else if (toletController.pricemax ==
                              widget.controller) {
                            toletController.rentmax.value = val as int;
                          }
                        },
                        onSubmitted: (v) {
                          getFocus();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
