import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/view/post/pro%20widget/page1.dart';
import 'package:btolet/view/post/pro%20widget/page2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostPro extends StatefulWidget {
  const PostPro({super.key});

  @override
  State<PostPro> createState() => _PostProState();
}

class _PostProState extends State<PostPro> {
  final ProController proController = Get.find();

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
            controller: proController.pageController,
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
              controller: proController.pageController,
              onPageChanged: (int i) {},
              children: const [
                PostPro1(),
                PostPro2(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
