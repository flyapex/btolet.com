import 'dart:convert';
import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/ads_controller.dart';
import 'package:btolet/view/home/widget/imageslider.dart';
import 'package:btolet/view/sort/tolet/sortingtolet.dart';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/home/widget/note.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../model/tolet_model.dart';
import 'single_post.dart';

class Tolet extends StatefulWidget {
  const Tolet({super.key});

  @override
  State<Tolet> createState() => _ToletState();
}

class _ToletState extends State<Tolet> with AutomaticKeepAliveClientMixin {
  ToletController toletController = Get.put(ToletController());
  LocationController locationController = Get.find();
  bool _atEnd = false;
  AdsController adsController = Get.put(AdsController());
  // getLocation() async {
  //   await locationController.getCurrnetlanlongLocation();
  // }

  @override
  void initState() {
    // getLocation();
    toletController.getAllPost();
    // adsController.createRewardedAd();
    // adsController.createRewardedInterstitialAd();
    super.initState();
  }

  // @override
  // void dispose() {
  //   adsController.rewardedAd?.dispose();
  //   adsController.rewardedInterstitialAd?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: NotificationListener(
      onNotification: (scrollNotification) {
        if (_atEnd &&
            scrollNotification is ScrollUpdateNotification &&
            scrollNotification.metrics.atEdge &&
            scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
          setState(() {
            _atEnd = false;
          });
        } else if (!_atEnd &&
            scrollNotification is ScrollEndNotification &&
            scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
          setState(() {
            _atEnd = true;
          });

          toletController.getAllPost();
          print('Reached the end of the list!');
        }
        return false;
      },
      child: Scrollbar(
        child: CustomRefreshIndicator(
          key: toletController.refreshkey,
          completeStateDuration: const Duration(milliseconds: 450),
          builder: MaterialIndicatorDelegate(
            backgroundColor: Colors.blueAccent,
            builder: (context, controller) {
              return SizedBox(
                child: LottieBuilder.asset(
                  'assets/lottie/ref.json',
                ),
              );
            },
          ),
          onRefresh: () async {
            // await locationController.getCurrnetlanlongLocation(
            //     false, 'Tolet Ref');
            toletController.getCurrentPostCount();
            toletController.allPost.clear();
            toletController.allPost.refresh();
            toletController.page.value = 1;
            toletController.getAllPost();
            toletController.allPost.sentToStream;
            setState(() {});
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Note(),
                const SizedBox(height: 20),
                const ImageSlide(
                  topPadding: 10.0,
                  height: 160, //180
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => toletController.currentPostCountLoding.value
                          ? const ShimmerSortPostCount()
                          : Flexible(
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      "${NumberFormat.decimalPattern().format(toletController.currentPostCount.value)} ads in ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: locationController
                                          .locationAddressShort.value
                                          .split(', ')[0],
                                      style: TextStyle(
                                        // fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                        color: Colors.black.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          const SortingTolet(),
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
                          border:
                              Border.all(color: Colors.black.withOpacity(0.3)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Feather.sliders,
                                    color: Colors.black45,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Filter',
                                    style: h3,
                                  ),
                                ],
                              ),
                              const Icon(Feather.chevron_down),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: toletController.allPost.stream,
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
                            if (toletController.lodingPosts.value) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                ),
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
    ));
  }

  @override
  bool get wantKeepAlive => true;
}

class PostsTolet extends StatefulWidget {
  final PostListTolet postData;
  final bool isLikedvalue;
  const PostsTolet({
    super.key,
    required this.postData,
    this.isLikedvalue = false,
  });

  @override
  State<PostsTolet> createState() => _PostsToletState();
}

class _PostsToletState extends State<PostsTolet> {
  ToletController toletController = Get.find();
  UserController userController = Get.find();
  AdsController adsController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;

    getCategory() {
      var catagory = json.decode(widget.postData.category).cast<String>();
      var data = widget.postData.garagetype;
      if (catagory.contains('Only Garage')) {
        if (data == "Garage") {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      'assets/icons/tolet/garage.svg',
                      colorFilter: ColorFilter.mode(
                        // Color(0xff083437),
                        const Color(0xff083437).withOpacity(0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "Garage", //Car & Bike
                      style: TextStyle(
                        color: Color(0xff083437),
                        fontSize: s5,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        } else if (data == "Bike") {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      'assets/icons/tolet/bike.svg',
                      colorFilter: ColorFilter.mode(
                        // Color(0xff083437),
                        const Color(0xff083437).withOpacity(0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "Bike", //Car & Bike
                      style: TextStyle(
                        color: Color(0xff083437),
                        fontSize: s5,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        } else {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 22,
                    width: 22,
                    child: SvgPicture.asset(
                      'assets/icons/tolet/car.svg',
                      colorFilter: ColorFilter.mode(
                        // Color(0xff083437),
                        const Color(0xff083437).withOpacity(0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      " ${widget.postData.garagetype}",
                      style: const TextStyle(
                        color: Color(0xff083437),
                        fontSize: s5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      } else if (catagory.contains('Office') || catagory.contains('Shop')) {
        return const SizedBox();
      } else {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/tolet/bed.svg',
                          colorFilter: ColorFilter.mode(
                            // Color(0xff083437),
                            const Color(0xff083437).withOpacity(0.5),
                            // Colors.black87,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Text(
                        "  ${widget.postData.bed}",
                        style: const TextStyle(
                          color: Color(0xff083437),
                          fontSize: s4,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: SvgPicture.asset(
                          'assets/icons/tolet/bath.svg',
                          colorFilter: ColorFilter.mode(
                            // Color(0xff083437),
                            const Color(0xff083437).withOpacity(0.5),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Text(
                        "  ${widget.postData.bath}",
                        style: const TextStyle(
                          color: Color(0xff083437),
                          fontSize: s4,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: widget.postData.roomsize == ''
                      ? Row(
                          children: [
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: SvgPicture.asset(
                                'assets/icons/tolet/kitchen.svg',
                                colorFilter: ColorFilter.mode(
                                  // Color(0xff083437),
                                  const Color(0xff083437).withOpacity(0.5),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            Text(
                              "  ${widget.postData.kitchen}",
                              style: const TextStyle(
                                color: Color(0xff083437),
                                fontSize: s4,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: SvgPicture.asset(
                                'assets/icons/tolet/size.svg',
                                colorFilter: ColorFilter.mode(
                                  // Color(0xff083437),
                                  const Color(0xff083437).withOpacity(0.5),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "  ${widget.postData.roomsize} ft\u00b2",
                                style: const TextStyle(
                                  color: Color(0xff083437),
                                  fontSize: s4,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ],
        );
      }
    }

    return Container(
      height: height / 7,
      width: width / 1.35,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12, width: 0.9)
          // boxShadow: const [
          //   BoxShadow(color: Colors.black12, spreadRadius: 1),
          // ],
          ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              toletController.singlePostloding(true);
              Get.to(
                () => SinglePostTolet(
                  postid: widget.postData.postId,
                ),
                transition: Transition.circularReveal,
                duration: const Duration(milliseconds: 600),
                preventDuplicates: false,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: width / 2.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image:
                              MemoryImage(base64Decode(widget.postData.image1)),
                          fit: BoxFit.cover,
                          // alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                        right: 4,
                        bottom: 6,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Material(
                          color: Colors.black38,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              bottom: 2,
                              top: 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.postData.totalImage.toString(),
                                  style: const TextStyle(
                                    fontSize: s6,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Feather.layers,
                                  color: Colors.white,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '৳ ',
                              style: TextStyle(
                                fontSize: 22,
                                color: const Color(0xff083437).withOpacity(0.8),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              NumberFormat.decimalPattern()
                                  .format(widget.postData.rent),
                              style: TextStyle(
                                fontSize: s1,
                                color: const Color(0xff083437).withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Text(
                          " ${((json.decode(widget.postData.category) as List).map((e) => e.toString()).toList()).join(', ')}",
                          style: const TextStyle(
                            height: 1,
                            color: Color(0xff083437),
                            fontSize: s4,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        getCategory(),
                        // const SizedBox(height: 6),
                        Text(
                          widget.postData.location,
                          style: TextStyle(
                            color: const Color(0xff083437).withOpacity(0.6),
                            fontSize: 12,
                            fontFamily: 'Roboto',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 30,
                width: 30,
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      Feather.share_2,
                      color: Colors.black.withOpacity(0.4),
                      size: 22,
                    ),
                  ),
                  onTap: () {
                    adsController.shareBase64Image(widget.postData.image1, '''
     🏷️ ${jsonDecode(widget.postData.category).join(", ")}
    💰Rent: ${widget.postData.rent} ৳
    📍Location: ${widget.postData.location}
    
Download our app now to discover more!🌟
Check out the latest updates here:
   https://play.google.com/store/apps/details?id=com.btolet.app
    ''');
                  },
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 10, top: 10),
          //   child: Align(
          //     alignment: Alignment.topRight,
          //     child: SizedBox(
          //       height: 30,
          //       width: 30,
          //       child: LikeButton(
          //         size: 26,
          //         isLiked: widget.isLikedvalue,
          //         // mainAxisAlignment: MainAxisAlignment.end,
          //         // crossAxisAlignment: CrossAxisAlignment.start,

          //         circleColor: const CircleColor(
          //           start: Color(0xff00ddff),
          //           end: Color(0xff0099cc),
          //         ),
          //         bubblesColor: const BubblesColor(
          //           dotPrimaryColor: Color(0xff33b5e5),
          //           dotSecondaryColor: Color(0xff0099cc),
          //         ),
          //         likeBuilder: (bool isLiked) {
          //           return Icon(
          //             isLiked ? Icons.favorite : Icons.favorite_border_outlined,
          //             color:
          //                 isLiked ? Colors.blue.withOpacity(0.9) : Colors.grey,
          //           );
          //         },
          //         animationDuration: const Duration(milliseconds: 400),
          //         onTap: (isLiked) async {
          //           print(!isLiked);
          //           toletController.save(
          //             widget.postData.postId,
          //             !isLiked,
          //           );
          //           return !isLiked;
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '${userController.getDay(widget.postData.time)}',
              style: TextStyle(
                color: const Color(0xff083437).withOpacity(0.8),
                fontSize: s6,
                height: 1,
              ),
            ),
          ).paddingOnly(right: 10, bottom: 2),
        ],
      ),
    );
  }
}
