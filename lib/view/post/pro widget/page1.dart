import 'package:btolet/api/google_api.dart';
import 'package:btolet/model/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import 'category_body.dart';
import 'chips.dart';
import 'imagepicker.dart';
import 'text_input.dart';

class PostPro1 extends StatefulWidget {
  const PostPro1({super.key});

  @override
  State<PostPro1> createState() => PostToletState1();
}

class PostToletState1 extends State<PostPro1> {
  double space = 20.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
          ? const SizedBox()
          : SizedBox(
              width: 140,
              height: 45,
              child: FloatingActionButton.extended(
                foregroundColor: const Color(0xff5E72E4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                elevation: 0,
                onPressed: () async {
                  proController.pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                ),
                label: const Text(
                  "NEXT",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PorCategoryChips(
              title: 'Category',
              options: category,
              selected: proController.selectedCategory,
            ),
            const CategoryBodyPro(),
            SizedBox(height: space),
            TextInputPro(
              topPadding: 0,
              title: "Youtube Video",
              textType: TextInputType.text,
              hintText: "youtu.be/xxxx",
              textlength: 500,
              suffixtext: "...",
              controller: proController.ytVideo,
              widthh: 1.2,
              focusNode: proController.ytVideofocusNode,
            ),
            Obx(() {
              return proController.selectedCategory.value == category[0] ||
                      proController.selectedCategory.value == category[1]
                  ? Column(
                      children: [
                        SizedBox(height: space),
                        Row(
                          children: [
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: SvgPicture.asset(
                                'assets/icons/property/floorplanpost.svg',
                                colorFilter: const ColorFilter.mode(
                                  // Color(0xff083437),
                                  Colors.black54,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Select floor Plan',
                              style: TextStyle(
                                color: Color(0xff7B7B7B),
                                letterSpacing: 0.7,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: space),
                        const ImagePickerProFloorPlan(
                          icon: Feather.image,
                          imagnumber: 1,
                          color: Colors.orange,
                        )
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: space),
                        const Row(
                          children: [
                            Text(
                              'Facilities(op)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Wrap(
                                spacing: 10,
                                children: proController.fasalitis2.entries
                                    .map((entry) {
                                  final String text = entry.key;
                                  final FasalitisModel fasalitis = entry.value;
                                  final categoryState = fasalitis.state;

                                  return FasalitisChipPro(
                                    text: text,
                                    icon: fasalitis.icon,
                                    categoryState: categoryState,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
            }),
            SizedBox(height: space),
            const Text(
              'Select Image',
              style: TextStyle(
                color: Color(0xff7B7B7B),
                letterSpacing: 0.7,
              ),
            ),
            SizedBox(height: space),
            const ImagePickerPro(
              icon: Feather.image,
              imagnumber: 12,
              color: Color(0xff5E72E4),
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
