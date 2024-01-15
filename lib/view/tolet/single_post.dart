import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:label_marker/label_marker.dart';
import 'package:like_button/like_button.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class SinglePostTolet extends StatefulWidget {
  final int postid;
  const SinglePostTolet({
    super.key,
    required this.postid,
  });

  @override
  State<SinglePostTolet> createState() => _SinglePostToletState();
}

class _SinglePostToletState extends State<SinglePostTolet> {
  ToletController toletController = Get.find();
  // AdsController adsController = Get.put(AdsController());
  UserController userController = Get.find();
  LocationController locationController = Get.find();

  lodeData() async {
    toletController.lodeOneTime(true);
    var data = await toletController.getSinglePost(widget.postid);
    if (data) {
      addMarker();
    }
  }

  final ScrollController _controller = ScrollController();
  final ScrollController _controllerMore = ScrollController();

  @override
  void initState() {
    lodeData();
    // rootBundle.loadString('assets/map/map_style.txt').then((string) {
    //   _mapStyle = string;
    // });

    _controller.addListener(_scrollListener);
    _controllerMore.addListener(_scrollListenerMore);
    super.initState();
    // adsController.createInterstitialAd();
    // adsController.createRewardedAd();
    // adsController.createRewardedInterstitialAd();
  }

  void _scrollListener() {
    if (_controller.position.maxScrollExtent > 0) {
      var scrollPercentage =
          (_controller.position.pixels / _controller.position.maxScrollExtent)
              .clamp(0.0, 1.0);

      if (scrollPercentage > 0.5 &&
          scrollPercentage < 0.6 &&
          toletController.lodeOneTime.value) {
        print("Lode More Data");
        toletController.getMorePost(
          1,
          toletController.singlepost.geolat,
          toletController.singlepost.geolon,
        );
      }
    }
    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      locationController.singlePostTolemap.value = true;
    } else {
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        locationController.singlePostTolemap.value = false;
      }
    }
  }

  var lodingPage = 2;
  void _scrollListenerMore() {
    if (_controllerMore.position.pixels ==
            _controllerMore.position.maxScrollExtent &&
        toletController.lodingmorePosts.value == false) {
      print("Lode More Page");
      toletController.getMorePost(
        lodingPage,
        toletController.singlepost.geolat,
        toletController.singlepost.geolon,
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
    // adsController.rewardedAd?.dispose();
    // adsController.rewardedInterstitialAd?.dispose();
  }

  // late String _mapStyle;
  Set<Marker> markers = {};
  void addMarker() async {
    await markers.addLabelMarker(
      LabelMarker(
        label:
            "৳ ${NumberFormat.decimalPattern().format(toletController.singlepost.rent)}",
        // label: data.rent.toString(),
        markerId: MarkerId(toletController.singlepost.postId.toString()),
        position: LatLng(double.parse(toletController.singlepost.geolat),
            double.parse(toletController.singlepost.geolon)),
        backgroundColor: Colors.orange,
        infoWindow: InfoWindow(
          title:
              '${toletController.singlepost.bed}bed,${toletController.singlepost.bath}bath,${toletController.singlepost.kitchen}kitchen',
        ),
        onTap: () async {},
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;

    return Obx(
      () => toletController.singlePostloding.value
          ? const SinglePostShimmer()
          : Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                height: 70,
                width: width,
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              final call = Uri.parse(
                                  'tel:${toletController.singlepost.phone}');
                              if (await canLaunchUrl(call)) {
                                launchUrl(call);
                              } else {
                                throw 'Could not launch $call';
                              }
                            },
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                // color: Colors.deepOrange,
                                color: const Color(0xffF36251),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              // ignore: prefer_const_constructors
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.call,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'CALL',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
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
                              var uri = Uri.parse(
                                  'sms:${toletController.singlepost.phone}?body=hello%20there');

                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              } else {
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri);
                                } else {
                                  throw 'Could not launch $uri';
                                }
                              }
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
                                  const Text(
                                    'SMS',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
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
                              String appUrl;
                              String phone = toletController.singlepost.wapp;
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
                                  const Text(
                                    'WhatsApp',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
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
                  ],
                ),
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ImageSlidePage(
                              hight: height / 3.5,
                              imageList: toletController.imageList,
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
                                        padding: EdgeInsets.only(left: 10),
                                        child: Icon(
                                          Feather.arrow_left,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ),
                                      onTap: () {
                                        Get.back();
                                      },
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          child: const Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Icon(
                                              Feather.share_2,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                          ),
                                          onTap: () {},
                                        ),
                                        const SizedBox(width: 10),
                                        LikeButton(
                                          size: 32,
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                                isLiked
                                                    ? Icons.favorite
                                                    : Icons
                                                        .favorite_border_outlined,
                                                color: isLiked
                                                    ? Colors.lightBlue
                                                    : Colors.white);
                                          },
                                          animationDuration:
                                              const Duration(milliseconds: 400),
                                          onTap: (isLiked) async {
                                            print(!isLiked);
                                            toletController.save(
                                              toletController.singlepost.postId,
                                              !isLiked,
                                            );
                                            return !isLiked;
                                          },
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
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "৳ ${NumberFormat.decimalPattern().format(toletController.singlepost.rent)}",
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Color(0xff083437),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  toletController.singlepost.garagetype == ""
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: SvgPicture.asset(
                                                      'assets/icons/tolet/bed.svg',
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                        Color(0xff083437),
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    '${toletController.singlepost.bed} Beds',
                                                    style: const TextStyle(
                                                      color: Color(0xff083437),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // const SizedBox(width: 20),
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    height: 28,
                                                    width: 28,
                                                    child: SvgPicture.asset(
                                                      'assets/icons/tolet/bath.svg',
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                        Color(0xff083437),
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    '${toletController.singlepost.bath} Baths',
                                                    style: const TextStyle(
                                                      color: Color(0xff083437),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // const SizedBox(width: 20),
                                            Expanded(
                                              flex: 1,
                                              child: toletController.singlepost
                                                          .roomsize ==
                                                      ''
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        SizedBox(
                                                          height: 24,
                                                          width: 24,
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/tolet/kitchen.svg',
                                                            colorFilter:
                                                                const ColorFilter
                                                                    .mode(
                                                              Color(0xff083437),
                                                              BlendMode.srcIn,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          "  ${toletController.singlepost.kitchen} Kitchen",
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xff083437),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/tolet/size.svg',
                                                            colorFilter:
                                                                const ColorFilter
                                                                    .mode(
                                                              Color(0xff083437),
                                                              BlendMode.srcIn,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Expanded(
                                                          child: Text(
                                                            "  ${toletController.singlepost.roomsize}", //ft\u00b2
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xff083437),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ],
                                        )
                                      : toletController.singlepost.garagetype ==
                                              "Car"
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 25,
                                                  width: 25,
                                                  child: SvgPicture.asset(
                                                    'assets/icons/tolet/car.svg',
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                      // Color(0xff083437),
                                                      Colors.black87,
                                                      BlendMode.srcIn,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4),
                                                  child: Text(
                                                    "${toletController.singlepost.garagetype} Garage",
                                                    style: const TextStyle(
                                                      color: Color(0xff083437),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                SizedBox(
                                                  height: 10,
                                                  width: 10,
                                                  child: SvgPicture.asset(
                                                    'assets/icons/tolet/security.svg',
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                      // Color(0xff083437),
                                                      Colors.green,
                                                      BlendMode.srcIn,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: SvgPicture.asset(
                                                    'assets/icons/tolet/bike.svg',
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                      // Color(0xff083437),
                                                      Colors.black87,
                                                      BlendMode.srcIn,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  "${toletController.singlepost.garagetype} Garage",
                                                  style: const TextStyle(
                                                    color: Color(0xff083437),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                SizedBox(
                                                  height: 10,
                                                  width: 10,
                                                  child: SvgPicture.asset(
                                                    'assets/icons/tolet/security.svg',
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                      // Color(0xff083437),
                                                      Colors.green,
                                                      BlendMode.srcIn,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final coords = Coords(
                                        double.parse(
                                            toletController.singlepost.geolat),
                                        double.parse(
                                            toletController.singlepost.geolon),
                                      );
                                      var title =
                                          "Price ৳ ${NumberFormat.decimalPattern().format(toletController.singlepost.rent)}";
                                      final availableMaps =
                                          await MapLauncher.installedMaps;
                                      // await availableMaps.first
                                      //     .showMarker(
                                      //   coords: coords,
                                      //   title: title,
                                      //   description: "description",
                                      // );
                                      // print(availableMaps.length);
                                      if (availableMaps.length == 1) {
                                        await availableMaps.first.showMarker(
                                          coords: coords,
                                          title: title,
                                          description: "description",
                                        );
                                      } else {
                                        Get.bottomSheet(
                                          SafeArea(
                                            child: SingleChildScrollView(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  bottom: 10,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    topRight:
                                                        Radius.circular(6),
                                                  ),
                                                ),
                                                child: Wrap(
                                                  children: <Widget>[
                                                    for (var map
                                                        in availableMaps)
                                                      ListTile(
                                                        onTap: () =>
                                                            map.showMarker(
                                                          coords: coords,
                                                          title: title,
                                                        ),
                                                        title:
                                                            Text(map.mapName),
                                                        leading:
                                                            SvgPicture.asset(
                                                          map.icon,
                                                          height: 30.0,
                                                          width: 30.0,
                                                        ),
                                                        trailing: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/home/arrow.svg',
                                                            height: 12,
                                                            width: 12,
                                                            // ignore: deprecated_member_use
                                                            color: const Color(
                                                                0xffAFAFAF),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Material(
                                          type: MaterialType.transparency,
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.blue,
                                                width: 2,
                                              ),
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SizedBox(
                                                  height: 22,
                                                  width: 22,
                                                  child: SvgPicture.asset(
                                                    'assets/icons/home/map.svg',
                                                    height: 10,
                                                    width: 22,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: width / 1.7,
                                          child: Text(
                                            // locationController.locationAddress.value,
                                            toletController.singlepost.location,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff083437),
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${userController.getDay(toletController.singlepost.time)}',
                                    // ' ${timeago.format(toletController.singlepost.time, locale: 'en_short')} ago',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff083437),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 20,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: const BoxDecoration(
                                color: Colors.black12,
                              ),
                              // child: const Row(
                              //   children: [
                              //     Text(
                              //       "tolet In Khulna, Nirala 14 Nirala",
                              //       style: TextStyle(
                              //         fontSize: 16,
                              //         color: Color(0xff083437),
                              //         fontWeight: FontWeight.normal,
                              //         overflow: TextOverflow.clip,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ),
                            // const SizedBox(height: 20),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 20, right: 20),
                            //   child: Container(
                            //     height: 100,
                            //     width: width,
                            //     decoration: BoxDecoration(
                            //       color: Colors.yellow,
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //     child: const Center(
                            //       child: Text('Ads'),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 20),
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Details",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff083437),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "id:${toletController.singlepost.postId}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: const Color(0xff083437)
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Details(
                                    type: "Property Name",
                                    detailstext:
                                        toletController.singlepost.propertyname,
                                    icon: Icons.home_rounded,
                                  ),

                                  Details(
                                    type: "Property Type",
                                    detailstext: json
                                        .decode(
                                            toletController.singlepost.category)
                                        .join(", "),
                                    icon: Icons.business_outlined,
                                  ),

                                  // const Details(
                                  //   type: "Bedrooms",
                                  //   detailstext: "5",
                                  //   icon: Icons.bedroom_parent_outlined,
                                  // ),
                                  // const SizedBox(height: 15),
                                  // const Details(
                                  //   type: "Bathrooms",
                                  //   detailstext: "2",
                                  //   icon: Icons.bathtub_outlined,
                                  // ),
                                  // const SizedBox(height: 15),
                                  Details(
                                    type: "Dining",
                                    detailstext:
                                        toletController.singlepost.dining,
                                    icon: Icons.dining_outlined,
                                  ),

                                  Details(
                                    type: "Kitchen",
                                    detailstext:
                                        toletController.singlepost.kitchen,
                                    icon: Icons.kitchen_rounded,
                                  ),
                                  // const SizedBox(height: 15),
                                  // const Details(
                                  //   type: "Room Size",
                                  //   detailstext: "450 m\u00b2(4,849 ft\u00b2)",
                                  //   icon: Icons.all_inclusive_rounded,
                                  // ),

                                  Details(
                                    type: "Floor",
                                    detailstext:
                                        toletController.singlepost.floornumber,
                                    icon: Icons.person_pin_circle_rounded,
                                  ),

                                  Details(
                                    type: "Facing",
                                    detailstext:
                                        toletController.singlepost.facing,
                                    icon: Icons.window_outlined,
                                  ),
                                  Details(
                                    type: "Rent From",
                                    detailstext: DateFormat('d MMM').format(
                                        toletController.singlepost.time),
                                    icon: Icons.access_time,
                                  ),

                                  Details(
                                    type: "Facilities",
                                    detailstext: toletController
                                            .singlepost.fasalitis.isEmpty
                                        ? ""
                                        : json
                                            .decode(toletController
                                                .singlepost.fasalitis)
                                            .join(", "),
                                    icon: Icons.search_sharp,
                                    textColor: Colors.green,
                                  ),

                                  Details(
                                    type: "Maintenance",
                                    detailstext: toletController
                                                .singlepost.mentenance ==
                                            0
                                        ? ""
                                        : "${NumberFormat.decimalPattern().format(toletController.singlepost.mentenance)} ৳/mon",
                                    icon: Icons.monetization_on_outlined,
                                  ),

                                  Details(
                                    type: "Short Address",
                                    detailstext:
                                        toletController.singlepost.shortaddress,
                                    icon: Icons.share_location_rounded,
                                  ),

                                  const SizedBox(height: 20),
                                  Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Feather.menu,
                                        color: const Color(0xff8595A9)
                                            .withOpacity(0.5),
                                        size: 18,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text("Discription"),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffE3E8FF),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                        right: 15,
                                        bottom: 20,
                                      ),
                                      child: Text(
                                        toletController.singlepost.description,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.clip,
                                        // maxLines: 5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "In Map",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff083437),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.2),
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
                                              // controller.setMapStyle(_mapStyle);
                                            },
                                            zoomControlsEnabled: false,
                                            myLocationButtonEnabled: false,
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: LatLng(
                                                double.parse(toletController
                                                    .singlepost.geolat),
                                                double.parse(toletController
                                                    .singlepost.geolon),
                                              ),
                                              zoom: 16.0,
                                            ),
                                            mapToolbarEnabled: false,
                                            markers: markers,
                                            compassEnabled: true,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: SizedBox(
                                              height: 40,
                                              child:
                                                  FloatingActionButton.extended(
                                                backgroundColor: Colors.blue,
                                                onPressed: () async {
                                                  final coords = Coords(
                                                    double.parse(toletController
                                                        .singlepost.geolat),
                                                    double.parse(toletController
                                                        .singlepost.geolon),
                                                  );
                                                  var title =
                                                      "Price ৳ ${NumberFormat.decimalPattern().format(toletController.singlepost.rent)}";
                                                  final availableMaps =
                                                      await MapLauncher
                                                          .installedMaps;
                                                  print(availableMaps.length);
                                                  if (availableMaps.length ==
                                                      1) {
                                                    await availableMaps.first
                                                        .showMarker(
                                                      coords: coords,
                                                      title: title,
                                                      description:
                                                          "description",
                                                    );
                                                  } else {
                                                    Get.bottomSheet(
                                                      SafeArea(
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Wrap(
                                                            children: <Widget>[
                                                              for (var map
                                                                  in availableMaps)
                                                                ListTile(
                                                                  onTap: () => map
                                                                      .showMarker(
                                                                    coords:
                                                                        coords,
                                                                    title:
                                                                        title,
                                                                  ),
                                                                  title: Text(map
                                                                      .mapName),
                                                                  leading:
                                                                      SvgPicture
                                                                          .asset(
                                                                    map.icon,
                                                                    height:
                                                                        30.0,
                                                                    width: 30.0,
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                shape: RoundedRectangleBorder(
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
                                                        fontSize: 14,
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
                            // const Row(
                            //   children: [
                            //     Padding(
                            //       padding: EdgeInsets.only(left: 20),
                            //       child: Text(
                            //         'more',
                            //         style: TextStyle(
                            //           fontSize: 13,
                            //           color: Colors.black38,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 20),

                            // SizedBox(
                            //   height: height / 7,
                            //   child: StreamBuilder(
                            //     stream: toletController.morePost.stream,
                            //     builder: (BuildContext context,
                            //         AsyncSnapshot snapshot) {
                            //       if (snapshot.data == null) {
                            //         return const PostListSuggstionSimmer(
                            //           topPadding: 0,
                            //           count: 4,
                            //         );
                            //       } else {
                            //         return ListView.builder(
                            //           controller: _controllerMore,
                            //           scrollDirection: Axis.horizontal,
                            //           shrinkWrap: true,
                            //           itemCount: snapshot.data.length + 1,
                            //           itemBuilder: (c, i) {
                            //             if (i < snapshot.data.length) {
                            //               return Padding(
                            //                 padding:
                            //                     const EdgeInsets.only(left: 20),
                            //                 child: Container(
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(10),
                            //                     border: Border.all(
                            //                       color: Colors.black
                            //                           .withOpacity(0.1),
                            //                       width: 0.4,
                            //                     ),
                            //                   ),
                            //                   child: MorePage(
                            //                     postData: snapshot.data[i],
                            //                   ),
                            //                 ),
                            //               );
                            //             } else {
                            //               return const Center(
                            //                 child: Padding(
                            //                   padding: EdgeInsets.all(20),
                            //                   child: CircularProgressIndicator(
                            //                     color: Colors.red,
                            //                   ),
                            //                 ),
                            //               );
                            //             }
                            //           },
                            //         );
                            //       }
                            //     },
                            //   ),
                            // ),
                            const SizedBox(height: 140),
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
            ),
    );
  }
}

class Details extends StatelessWidget {
  final String type;
  final String detailstext;
  final IconData icon;
  final Color textColor;

  const Details({
    super.key,
    required this.type,
    required this.detailstext,
    required this.icon,
    this.textColor = const Color(0xff083437),
  });

  @override
  Widget build(BuildContext context) {
    return detailstext.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          color: const Color(0xff083437),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          type,
                          style: const TextStyle(
                            color: Color(0xff083437),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      detailstext,
                      style: TextStyle(
                        color: textColor,
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
  // toletController toletController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
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
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(
                    'assets/logo/logo.svg',
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    height: 16,
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
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SvgPicture.asset(
                      'assets/logo/logo.svg',
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      height: 16,
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
