import 'dart:async';
import 'dart:convert';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/widget/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageSlideTolet extends StatefulWidget {
  final double topPadding;
  final double hight;
  const ImageSlideTolet({
    this.topPadding = 0,
    Key? key,
    required this.hight,
  }) : super(key: key);

  @override
  State<ImageSlideTolet> createState() => _ImageSlideToletState();
}

class _ImageSlideToletState extends State<ImageSlideTolet> {
  final PageController pageController = PageController(initialPage: 0);
  final UserController bannerController = Get.put(UserController());

  int _currentPage = 0;
  late Timer _timer;

  Future getBannerAds() async {
    if (bannerController.fatchOneTime.value) {
      await bannerController.bannerApi();
    }
    // await bannerController.bannerApi();
  }

  @override
  void initState() {
    getBannerAds();
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < bannerController.banneradsList.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (pageController.hasClients) {
        pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    // bannerController.banneradsList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      (() {
        return Container(
          height: widget.hight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: bannerController.bannerLoding.value
                ? Colors.white
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: bannerController.bannerLoding.value
              ? const Center(
                  child: AdsBannerShimmer(),
                )
              : Stack(
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemCount: bannerController.banneradsList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse(
                                bannerController.banneradsList[index].url);

                            if (!await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                image: MemoryImage(
                                  base64Decode(
                                    bannerController.banneradsList[index].image,
                                  ),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                      onPageChanged: (index) {},
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: bannerController.banneradsList.length,
                          effect: const ExpandingDotsEffect(
                            dotWidth: 7.5,
                            dotHeight: 7.5,
                            spacing: 10,
                            dotColor: Colors.white,
                            activeDotColor: Colors.white,
                          ),
                          onDotClicked: (index) {},
                        ),
                      ),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}
