import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/property/property.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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
            style: TextStyle(
              height: 0.7,
              color: Colors.black.withOpacity(0.5),
              fontSize: s3,
            ),
          ).paddingOnly(bottom: 2),
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
        label: Text(text, style: h3).paddingOnly(bottom: 2),
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
              shape: const StadiumBorder(side: BorderSide()),
              // padding: const EdgeInsets.only(left: 5, right: 5),
              // labelPadding: const EdgeInsets.only(right: 5, left: 5),
              label: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected[index]
                      ? const Color(0xff0166EE)
                      : Colors.black.withOpacity(0.5),
                  fontSize: s3,
                  height: 0.5,
                ),
              ).paddingOnly(bottom: 2),
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

class SortPostListPro extends StatefulWidget {
  const SortPostListPro({super.key});

  @override
  State<SortPostListPro> createState() => SortPostListProState();
}

class SortPostListProState extends State<SortPostListPro> {
  ProController proController = Get.find();
  final scrollController = ScrollController();
  @override
  void initState() {
    proController.sortedPostList();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("You're at the top.");
        } else {
          print("You're at the bottom.");
          proController.sortedPostList();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    proController.allSortedPost.clear();
    proController.sortpage.value = 1;
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
                  stream: proController.allSortedPost.stream,
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
                              child: PostsPro(
                                postData: snapshot.data[i],
                              ),
                            );
                          } else {
                            if (proController.sortloding.value) {
                              return const PostListSimmer(
                                topPadding: 20,
                                count: 3,
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'nothing more to load!',
                                    style: h4,
                                  ),
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

class TextInputProSort extends StatefulWidget {
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
  const TextInputProSort({
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
  State<TextInputProSort> createState() => _TextInputProSortState();
}

class _TextInputProSortState extends State<TextInputProSort> {
  ProController proController = Get.find();
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
      proController.priceminfocusNode: proController.pricemaxfocusNode,
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
            letterSpacing: 0.7,
            color: Colors.black.withOpacity(0.6),
            fontSize: s2,
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
                      if (val) {
                        if (proController.pricemin == widget.controller) {
                          proController.pricemin.text =
                              proController.rentmin.value.toString();
                        } else if (proController.pricemax ==
                            widget.controller) {
                          proController.pricemax.text =
                              proController.rentmax.value.toString();
                        }
                      }
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
                          if (proController.pricemin == widget.controller) {
                            proController.rentmin.value = val as int;
                          } else if (proController.pricemax ==
                              widget.controller) {
                            proController.rentmax.value = val as int;
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
