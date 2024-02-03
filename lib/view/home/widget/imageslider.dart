import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageSlide extends StatefulWidget {
  final double topPadding;
  final double height;
  const ImageSlide({
    this.topPadding = 0,
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  State<ImageSlide> createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  // final PageController pageController = PageController(initialPage: 0);
  final SwiperController swiperController = SwiperController();
  final UserController bannerController = Get.put(UserController());
  UserController userController = Get.find();
  // late List<Image> decodedImages;

  // Future getBannerAds() async {
  //   if (bannerController.fatchOneTime.value) {
  //     await bannerController.bannerApi();
  //     // decodedImages = decodeImages();
  //   }
  // }

  // @override
  // void initState() {
  //   getBannerAds();

  //   super.initState();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      (() {
        return Container(
          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: bannerController.bannerLoding.value
                ? Colors.white
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: bannerController.bannerLoding.value
              ? const Center(
                  child: BannerAdsShimmer(),
                )
              : Stack(
                  children: [
                    Swiper(
                      allowImplicitScrolling: true,
                      layout: SwiperLayout.DEFAULT,
                      controller: swiperController,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            print("object");
                            print(bannerController.banneradsList[index].url);
                            final Uri url = Uri.parse(
                                bannerController.banneradsList[index].url);

                            if (!await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: SizedBox(
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: userController.bannerImage[index],
                            ),
                          ),
                        );
                      },
                      autoplay: true,
                      itemCount: bannerController.banneradsList.length,
                      indicatorLayout: PageIndicatorLayout.SCALE,
                      pagination: SwiperCustomPagination(builder:
                          (BuildContext context, SwiperPluginConfig config) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: AnimatedSmoothIndicator(
                                  activeIndex: config.activeIndex.toInt(),
                                  count: config.itemCount,
                                  effect: const ExpandingDotsEffect(
                                    dotWidth: 7.5,
                                    dotHeight: 7.5,
                                    spacing: 10,
                                    dotColor: Colors.white,
                                    activeDotColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      onIndexChanged: (index) {},
                      autoplayDelay: 3000,
                    ),
                  ],
                ),
        );
      }),
    );
  }
}
