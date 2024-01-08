import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'tolet widget/page1.dart';
import 'tolet widget/page2.dart';

class PostTolet extends StatefulWidget {
  const PostTolet({super.key});

  @override
  State<PostTolet> createState() => _PostToletState();
}

class _PostToletState extends State<PostTolet> {
  final ToletController toletController = Get.find();
  final UserController userController = Get.find();
  @override
  void dispose() {
    toletController.activeFlag(false);
    toletController.categoryFlag.value = false;
    toletController.bedFlag(false);
    toletController.bathFlag(false);
    toletController.kitchenFlag(false);
    toletController.priceFlag(false);
    toletController.imageFlag(false);
    toletController.floorFlag(false);
    userController.phoneFlag(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 100),
      height: Get.height - 80,
      width: Get.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.only(top: 5, bottom: 15),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SmoothPageIndicator(
            controller: toletController.pageController,
            count: 2,
            effect: const ExpandingDotsEffect(
              dotWidth: 12,
              dotHeight: 12,
              spacing: 10,
              dotColor: Colors.greenAccent,
              activeDotColor: Colors.blueAccent,
            ),
            onDotClicked: (index) {},
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PageView(
              controller: toletController.pageController,
              onPageChanged: (int i) {},
              children: const [
                PostTolet1(),
                PostTolet2(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
