import 'dart:io';
import 'dart:ui';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/view/home/sorting/sortingproperty.dart';
import 'package:btolet/view/home/widget/imageslidetolet.dart';
import 'package:btolet/view/home/widget/post_btn.dart';
import 'package:btolet/view/post/property/propertypost.dart';
import 'package:btolet/view/tolet/tolet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'propertypage.dart';

class PropertyHome extends StatefulWidget {
  const PropertyHome({super.key});

  @override
  State<PropertyHome> createState() => _PropertyHomeState();
}

class _PropertyHomeState extends State<PropertyHome>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  LocationController locationController = Get.find();
  final scrollController = ScrollController();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )
    ..addListener(() {
      // setState(() {});
    })
    ..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    end: Offset.zero,
    begin: const Offset(0, 3.4),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ),
  );

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // print("You're at the top.");
        } else {
          // postController.getAllPost();
        }
      }
      if (scrollController.position.pixels > 0) {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_offsetAnimation.isCompleted) {
            _controller.reverse();
          }
          print("---------reverse--------");
        }
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          {
            _controller.forward();
            print("---------forward--------");
          }
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double wt = Get.width;
    super.build(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: locationController.mapMode.value
          ? const SizedBox()
          : SlideTransition(
              position: _offsetAnimation,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: SizedBox(
                    height: wt / 9,
                    width: wt / 3.5,
                    child: UnicornOutlineButton(
                      onPressed: () {
                        Get.bottomSheet(
                          const PostNowProperty(),
                          elevation: 20.0,
                          enableDrag: true,
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          ignoreSafeArea: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          enterBottomSheetDuration:
                              const Duration(milliseconds: 170),
                        );
                      },
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.cyanAccent, Colors.yellow],
                      ),
                      strokeWidth: 4,
                      radius: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 18,
                            width: 18,
                            child: SvgPicture.asset(
                              'assets/icons/plus.svg',
                              colorFilter: const ColorFilter.mode(
                                Color(0xff083437),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "Post",
                            style: TextStyle(
                              color: Color(0xff083437),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
      body: SingleChildScrollView(
        // physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Note(),
            const SizedBox(height: 20),
            const ImageSlideTolet(
              topPadding: 10.0,
              hight: 160, //180
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: ' 11,983 ads in ',
                    style: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(0.8)),
                    children: const [
                      TextSpan(
                        text: 'Khulna',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      const SortingProperty(),
                      elevation: 20.0,
                      enableDrag: true,
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      ignoreSafeArea: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      enterBottomSheetDuration:
                          const Duration(milliseconds: 170),
                    );
                  },
                  child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black.withOpacity(0.3)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Feather.sliders,
                                color: Colors.black45,
                                size: 20,
                              ),
                              SizedBox(width: 6),
                              Text('Filter'),
                            ],
                          ),
                          Icon(Feather.chevron_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Scrollbar(
              radius: const Radius.circular(20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 50,
                itemBuilder: (context, i) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: PostsProperty(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PostsProperty extends StatelessWidget {
  const PostsProperty({super.key});

  @override
  Widget build(BuildContext context) {
    // var height = Get.height;
    // var width = Get.width;
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, spreadRadius: 1.1),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => const PropertyPage(),
                    transition: Transition.circularReveal,
                    duration: const Duration(milliseconds: 600),
                  );
                },
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://blog.constructionpoint.pk/wp-content/uploads/2022/05/Apartment-Building.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://blog.constructionpoint.pk/wp-content/uploads/2022/05/Apartment-Building.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LikeButton(
                      size: 30,
                      likeBuilder: (bool isLiked) {
                        return Container(
                          decoration: BoxDecoration(
                            color: isLiked ? Colors.white : Colors.black26,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            isLiked
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: isLiked ? Colors.lightBlue : Colors.white,
                          ),
                        );
                      },
                      animationDuration: const Duration(milliseconds: 400),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Material(
                        color: Colors.black26,
                        child: InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Feather.share_2,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "৳ 2000 ",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff083437),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Row(
                  children: [
                    Icon(
                      Feather.map_pin,
                      size: 16,
                      color: Colors.black45,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Nirala 12, Khulna",
                      style: TextStyle(
                        color: Color(0xff083437),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: SizedBox(
                        height: 28,
                        width: 28,
                        child: SvgPicture.asset(
                          'assets/icons/property/bed.svg',
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "3",
                      style: TextStyle(
                        color: Color(0xff083437),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset(
                        'assets/icons/property/bath.svg',
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "2",
                      style: TextStyle(
                        color: Color(0xff083437),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 21,
                      width: 21,
                      child: SvgPicture.asset(
                        'assets/icons/property/size.svg',
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "1250 (ft\u00b2)",
                      style: TextStyle(
                        color: Color(0xff083437),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://lh3.googleusercontent.com/a/AAcHTtdx1wQM-1NXgarrI1Ya4-6q0OtKawcqY55DHK3YBw"),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Listed 2 week ago",
                      style: TextStyle(
                        color: const Color(0xff083437).withOpacity(0.4),
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          color: Colors.deepOrange,
                          child: InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.call,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () async {
                              final call = Uri.parse('tel:01612217208');
                              if (await canLaunchUrl(call)) {
                                launchUrl(call);
                              } else {
                                throw 'Could not launch $call';
                              }
                            },
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          color: Colors.green[400],
                          child: InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.message,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () async {
                              final sms = Uri.parse('sms:01612217208');
                              if (await canLaunchUrl(sms)) {
                                launchUrl(sms);
                              } else {
                                throw 'Could not launch $sms';
                              }
                            },
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          color: Colors.green[400],
                          child: InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(9),
                              child: Icon(
                                Feather.map_pin,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () async {
                              String appUrl;
                              String phone = '+8801612217208';
                              String message = 'Surprice Bitch! ';
                              if (Platform.isAndroid) {
                                appUrl =
                                    "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
                              } else {
                                appUrl =
                                    "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // URL for non-Android devices
                              }

                              if (await canLaunchUrl(Uri.parse(appUrl))) {
                                await launchUrl(Uri.parse(appUrl));
                              } else {
                                throw 'Could not launch $appUrl';
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
