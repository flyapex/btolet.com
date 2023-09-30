import 'package:btolet/controller/post_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'postpage1.dart';
import 'postpage2.dart';

class PostNow extends StatefulWidget {
  const PostNow({super.key});

  @override
  State<PostNow> createState() => _PostNowState();
}

class _PostNowState extends State<PostNow> {
  final PostController postController = Get.put(PostController());

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
            controller: postController.pageController,
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
              controller: postController.pageController,
              onPageChanged: (int i) {},
              children: const [
                PostPage1(),
                PostPage2(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
