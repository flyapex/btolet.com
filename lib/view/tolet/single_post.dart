import 'dart:convert';
import 'dart:ui';
import 'package:btolet/api/api_tolet.dart';
import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/ads_controller.dart';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/error/emptypage.dart';
import 'package:btolet/model/tolet_model.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:label_marker/label_marker.dart';
import 'package:like_button/like_button.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'morepost.dart';
import 'widget/category.dart';

class SinglePostTolet extends StatefulWidget {
  final int postid;

  const SinglePostTolet({
    super.key,
    required this.postid,
  });

  @override
  State<SinglePostTolet> createState() => _SinglePostToletState();
}

class _SinglePostToletState extends State<SinglePostTolet>
    with AutomaticKeepAliveClientMixin {
  ToletController toletController = Get.find();
  AdsController adsController = Get.find();
  UserController userController = Get.find();
  LocationController locationController = Get.find();
  late SingleToletPostModel postData;
  getImage(
    data1,
    data2,
    data3,
    data4,
    data5,
    data6,
    data7,
    data8,
    data9,
    data10,
    data11,
    data12,
  ) {
    var imageList = [];
    if (data1 != '') {
      imageList.add(data1);
    }
    if (data2 != '') {
      imageList.add(data2);
    }
    if (data3 != '') {
      imageList.add(data3);
    }
    if (data4 != '') {
      imageList.add(data4);
    }
    if (data5 != '') {
      imageList.add(data5);
    }
    if (data6 != '') {
      imageList.add(data6);
    }
    if (data7 != '') {
      imageList.add(data7);
    }
    if (data8 != '') {
      imageList.add(data8);
    }
    if (data9 != '') {
      imageList.add(data9);
    }
    if (data10 != '') {
      imageList.add(data10);
    }
    if (data11 != '') {
      imageList.add(data11);
    }
    if (data12 != '') {
      imageList.add(data12);
    }
    return imageList;
  }

  lodeData() async {
    // toletController.lodeOneTime(true);
    var data = await toletController.getSinglePost(widget.postid);
    if (data != null) {
      postData = data;
      addMarker();
    }
  }

  final ScrollController _controller = ScrollController();
  final ScrollController _controllerMore = ScrollController();

  late bool morePost;

  @override
  void initState() {
    morePost = false;
    rootBundle.loadString('assets/map/map_style2.txt').then((string) {
      _mapStyle = string;
    });
    lodeData();
    // adsController.createRewardedAd();
    // adsController.createRewardedInterstitialAd();
    _controller.addListener(_scrollListener);
    _controllerMore.addListener(_scrollListenerMore);
    super.initState();
  }

  var lodingmorePosts = true.obs;
  var morePostList = [].obs;
  void getMorePost(postid, category, page, latitude, longitude) async {
    lodingmorePosts(true);
    try {
      var response = await ApiServiceTolet.getMorePost(
        postid,
        category,
        page,
        latitude,
        longitude,
      );
      if (response != null) {
        morePostList.addAll(response);
        if (response.isEmpty || response.length < 4) {
          lodingmorePosts(false);
        }
      }
    } finally {
      print('ModeList Count ${morePostList.length}');
    }
  }

  void _scrollListener() {
    double scrollPosition = _controller.position.pixels;

    double totalPageHeight = _controller.position.maxScrollExtent;
    double seventyPercentOfPage = 0.6 * totalPageHeight;
    if (scrollPosition >= seventyPercentOfPage && !morePost) {
      print("Load More Post Now");
      getMorePost(
        postData.postId,
        postData.category,
        1,
        postData.geolat,
        postData.geolon,
      );

      setState(() {
        morePost = true;
      });
    }
  }

  var lodingPage = 2;
  void _scrollListenerMore() {
    if (_controllerMore.position.pixels ==
        _controllerMore.position.maxScrollExtent) {
      print("Lode More Page");
      getMorePost(
        postData.postId,
        postData.category,
        lodingPage,
        postData.geolat,
        postData.geolon,
      );

      print(lodingPage);
      lodingPage++;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

    // adsController.interstitialAd?.dispose();

    // adsController.rewardedInterstitialAd?.dispose();
    // adsController.rewardedAd?.dispose();
  }

  late String _mapStyle;
  Set<Marker> markers = {};
  void addMarker() async {
    await markers.addLabelMarker(
      LabelMarker(
        label: "৳ ${NumberFormat.decimalPattern().format(postData.rent)}",
        // label: data.rent.toString(),
        markerId: MarkerId(postData.postId.toString()),
        position: LatLng(
            double.parse(postData.geolat), double.parse(postData.geolon)),
        backgroundColor: Colors.orange,
        infoWindow: InfoWindow(
          title:
              '${postData.bed}bed,${postData.bath}bath,${postData.kitchen}kitchen',
        ),
        onTap: () async {},
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var height = Get.height;
    var width = Get.width;

    return Obx(
      () => toletController.singlePostloding.value
          ? const SinglePostShimmer()
          : toletController.singlePostNull.value
              ? const EmptyPage(
                  appBarTitle: 'Back',
                  bodyText: 'Sorry, The post has been deleted.',
                  smallText: 'Try Another One🤝',
                  lottieasset: 'assets/lottie/404.json',
                )
              : Scaffold(
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        controller: _controller,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ImageSlidePage(
                                  hight: height / 3.5,
                                  imageList: getImage(
                                    postData.image1,
                                    postData.image2,
                                    postData.image3,
                                    postData.image4,
                                    postData.image5,
                                    postData.image6,
                                    postData.image7,
                                    postData.image8,
                                    postData.image9,
                                    postData.image10,
                                    postData.image11,
                                    postData.image12,
                                  ),
                                ),
                                Column(
                                  children: [
                                    const SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: const Padding(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Icon(
                                              // Feather.arrow_left,
                                              Feather.chevron_left,
                                              color: Colors.white,
                                              // size: 22,
                                              size: 24,
                                            ),
                                          ),
                                          onTap: () {
                                            Get.back();
                                          },
                                        ),
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Material(
                                                color: Colors.black26,
                                                child: LikeButton(
                                                  size: 32,
                                                  likeBuilder: (bool isLiked) {
                                                    return Icon(
                                                      isLiked
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border_outlined,
                                                      color: isLiked
                                                          ? Colors
                                                              .lightBlueAccent
                                                          : Colors.white,
                                                    );
                                                  },
                                                  animationDuration:
                                                      const Duration(
                                                          milliseconds: 400),
                                                  onTap: (isLiked) async {
                                                    print(!isLiked);
                                                    toletController.save(
                                                      postData.postId,
                                                      !isLiked,
                                                    );
                                                    return !isLiked;
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Material(
                                                color: Colors.black26,
                                                child: InkWell(
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Icon(
                                                      Feather.share_2,
                                                      color: Colors.white,
                                                      size: 22,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    adsController
                                                        .shareBase64Image(
                                                            postData.image1, '''
     🏷️ ${postData.category}
    💰Rent: ${postData.rent} ৳
    📍Location: ${postData.location}
    
Download our app now to discover more!🌟
Check out the latest updates here:
   https://play.google.com/store/apps/details?id=com.btolet.app
    ''');
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                CategoryBodyPost(
                                  postData: postData,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      const Text(
                                        "In Map",
                                        style: TextStyle(
                                          fontSize: s3,
                                          color: Color(0xff083437),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: GoogleMap(
                                                padding: const EdgeInsets.only(
                                                  bottom: 500,
                                                  top: 0,
                                                  right: 0,
                                                  left: 0,
                                                ),
                                                onMapCreated: (controller) {
                                                  controller
                                                      .setMapStyle(_mapStyle);
                                                },
                                                zoomControlsEnabled: false,
                                                myLocationButtonEnabled: false,
                                                initialCameraPosition:
                                                    CameraPosition(
                                                  target: LatLng(
                                                    double.parse(
                                                        postData.geolat),
                                                    double.parse(
                                                        postData.geolon),
                                                  ),
                                                  zoom: 16.0,
                                                ),
                                                mapToolbarEnabled: false,
                                                markers: markers,
                                                compassEnabled: true,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: SizedBox(
                                                  height: 40,
                                                  child: FloatingActionButton
                                                      .extended(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    onPressed: () async {
                                                      final coords = Coords(
                                                        double.parse(
                                                            postData.geolat),
                                                        double.parse(
                                                            postData.geolon),
                                                      );
                                                      var title =
                                                          "Price ৳ ${NumberFormat.decimalPattern().format(postData.rent)}";
                                                      final availableMaps =
                                                          await MapLauncher
                                                              .installedMaps;
                                                      await availableMaps.first
                                                          .showMarker(
                                                        coords: coords,
                                                        title: title,
                                                        description:
                                                            "description",
                                                      );
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      // side: const BorderSide(
                                                      //     width: 3,
                                                      //     color: Colors.brown),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        100,
                                                      ),
                                                    ),
                                                    label: const Row(
                                                      children: [
                                                        Text(
                                                          'Map',
                                                          style: TextStyle(
                                                            fontSize: s3,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Icon(
                                                          Feather.navigation,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                      ],
                                                    ),
                                                    elevation: 0,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        'more',
                                        style: TextStyle(
                                          fontSize: s4,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 130,
                                  child: StreamBuilder(
                                    stream: morePostList.stream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.data == null) {
                                        return const PostListSuggstionSimmer(
                                          topPadding: 0,
                                          count: 4,
                                        );
                                      } else {
                                        return ListView.builder(
                                          physics: const BouncingScrollPhysics(
                                            parent:
                                                AlwaysScrollableScrollPhysics(),
                                          ),
                                          controller: _controllerMore,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.length + 1,
                                          itemBuilder: (c, i) {
                                            if (i < snapshot.data.length) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      width: 0.4,
                                                    ),
                                                  ),
                                                  child: MoreTolet(
                                                    postData: snapshot.data[i],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              if (lodingmorePosts.value) {
                                                return const Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(20),
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Text(''),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 80),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // AnimatedSlide(
                      //   duration: const Duration(milliseconds: 800),
                      //   offset: locationController.singlePostTolemap.value
                      //       ? Offset.zero
                      //       : const Offset(0, 2),
                      //   child: AnimatedOpacity(
                      //     duration: const Duration(milliseconds: 800),
                      //     opacity:
                      //         locationController.singlePostTolemap.value ? 1 : 0,
                      //     child: Align(
                      //       alignment: Alignment.bottomCenter,
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(bottom: 80),
                      //         child: SizedBox(
                      //           height: 40,
                      //           child: FloatingActionButton.extended(
                      //             onPressed: () {},
                      //             label: const Row(
                      //               children: [
                      //                 Icon(Icons.map_rounded),
                      //                 Text(
                      //                   'Map',
                      //                   style: TextStyle(
                      //                     fontSize: 14,
                      //                     color: Colors.black,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             elevation: 0,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    height: 75,
                    width: width,
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Colors.white,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              print(postData.phone);
                              // adsController.showRewardedAd(
                              //   'call',
                              //   postData.phone,
                              // );
                              // final call = Uri.parse('tel:${postData.phone}');
                              // if (await canLaunchUrl(call)) {
                              //   launchUrl(call);
                              // } else {
                              //   throw 'Could not launch $call';
                              // }
                            },
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                // color: Colors.deepOrange,
                                color: const Color(0xffF36251),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  SizedBox(width: 5),
                                  Flexible(
                                    child: Text(
                                      'CALL',
                                      style: TextStyle(
                                        fontSize: s2,
                                        color: Colors.white,
                                        height: 0.7,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              // adsController.showRewardedInterstitialAd(
                              //   'sms',
                              //   postData.phone,
                              // );
                              // final sms = Uri.parse('sms:${postData.phone}');
                              // if (await canLaunchUrl(sms)) {
                              //   launchUrl(sms);
                              // } else {
                              //   throw 'Could not launch $sms';
                              // }
                            },
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                // color: Colors.blueAccent,
                                color: Colors.blue,
                                // color: const Color(0xff27D468),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 23,
                                    width: 23,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icons/home/message.svg',
                                        colorFilter: const ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Flexible(
                                    child: Text(
                                      'SMS',
                                      style: TextStyle(
                                        fontSize: s2,
                                        height: 0.7,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () async {
                              // adsController.showRewardedInterstitialAd(
                              //   'wapp',
                              //   postData.phone,
                              // );

                              // var message =
                              //     'Hi There I Just Saw A ads On btolet app, Is it available?';
                              // await launchUrl(Uri.parse(
                              //     "whatsapp://send?phone=${postData.wapp}&text=${Uri.parse(message)}"));
                            },
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xff27D468),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: SvgPicture.asset(
                                      'assets/icons/home/wapp.svg',
                                      height: 10,
                                      width: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Flexible(
                                    child: Text(
                                      'WhatsApp',
                                      style: TextStyle(
                                        fontSize: s2,
                                        height: 0.7,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Details extends StatelessWidget {
  final String type;
  final String detailstext;
  final IconData icon;
  final Color textColor;
  final String fontfamily;
  final double fontSize;
  const Details({
    super.key,
    required this.type,
    required this.detailstext,
    required this.icon,
    this.textColor = const Color(0xff083437),
    this.fontfamily = 'x',
    this.fontSize = s4,
  });

  @override
  Widget build(BuildContext context) {
    return detailstext.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          color: const Color(0xff083437).withOpacity(0.5),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          type,
                          style: TextStyle(
                            fontSize: s4,
                            color: const Color(0xff083437).withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      detailstext,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: textColor,
                        fontFamily: fontfamily,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}

class ImageSlidePage extends StatefulWidget {
  final double topPadding;
  final double hight;
  final List imageList;

  const ImageSlidePage({
    this.topPadding = 0,
    Key? key,
    required this.hight,
    required this.imageList,
  }) : super(key: key);

  @override
  State<ImageSlidePage> createState() => _ImageSlidePageState();
}

class _ImageSlidePageState extends State<ImageSlidePage> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    print(widget.imageList.length);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          ImageFullView(
            currentPage: (pageController.page ?? 0).toInt(),
            imagelist: widget.imageList,
          ),
        );
      },
      child: SizedBox(
        height: widget.hight,
        width: double.infinity,
        child: Stack(
          children: [
            PageView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              controller: pageController,
              itemCount: widget.imageList.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        image: DecorationImage(
                          image: MemoryImage(
                            base64Decode(
                              widget.imageList[index],
                            ),
                          ),
                          // fit: BoxFit.fitWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
              },
              onPageChanged: (index) {},
            ),
            widget.imageList.length == 1
                ? Container()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: widget.imageList.length,
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
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  'assets/logo/logo.svg',
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.5),
                    BlendMode.srcIn,
                  ),
                  height: 60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageFullView extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final currentPage;
  // ignore: prefer_typing_uninitialized_variables
  final imagelist;
  const ImageFullView({
    Key? key,
    this.currentPage,
    this.imagelist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        PageController(initialPage: currentPage);
    return Scaffold(
      body: InkWell(
        onDoubleTap: () {
          Get.back();
        },
        child: SizedBox(
          // height: 350,
          width: double.infinity,

          child: Stack(
            children: [
              PageView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                controller: pageController,
                itemCount: imagelist.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          image: DecorationImage(
                            image: MemoryImage(
                              base64Decode(
                                imagelist[index],
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.grey.withOpacity(0.1),
                            child: Image.memory(
                              base64Decode(
                                imagelist[index],
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                onPageChanged: (index) {},
              ),
              imagelist.length == 1
                  ? Container()
                  : SafeArea(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: imagelist.length,
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
                    ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SvgPicture.asset(
                        'assets/logo/logo.svg',
                        colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.5),
                          BlendMode.srcIn,
                        ),
                        height: 60,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
