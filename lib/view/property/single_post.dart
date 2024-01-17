import 'dart:convert';
import 'dart:io';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:btolet/model/pro_model.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:btolet/view/tolet/single_post.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:like_button/like_button.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'morepost.dart';

class SinglePostPro extends StatefulWidget {
  final int pid;
  const SinglePostPro({super.key, required this.pid});

  @override
  State<SinglePostPro> createState() => _SinglePostProState();
}

class _SinglePostProState extends State<SinglePostPro>
    with AutomaticKeepAliveClientMixin {
  ProController proController = Get.find();
  LocationController locationController = Get.find();
  late SinglePostModel postData;
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
    proController.lodeOneTime(true);
    var data = await proController.getSinglePost(widget.pid);
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
    lodeData();
    rootBundle.loadString('assets/map/map_style.txt').then((string) {
      _mapStyle = string;
    });
    _controller.addListener(_scrollListener);
    _controllerMore.addListener(_scrollListenerMore);
    super.initState();
  }

  void _scrollListener() {
    double scrollPosition = _controller.position.pixels;

    double totalPageHeight = _controller.position.maxScrollExtent;
    double seventyPercentOfPage = 0.7 * totalPageHeight;
    if (scrollPosition >= seventyPercentOfPage && !morePost) {
      print("Load More Post Now");
      proController.getMorePost(
        1,
        postData.geolat,
        postData.geolon,
      );
      setState(() {
        morePost = true;
      });
    }
    // if (_controller.position.maxScrollExtent > 0) {
    //   var scrollPercentage =
    //       (_controller.position.pixels / _controller.position.maxScrollExtent)
    //           .clamp(0.0, 1.0);

    //   if (scrollPercentage > 0.5 &&
    //       scrollPercentage < 0.6 &&
    //       proController.lodeOneTime.value) {
    //     print("Lode More Data");
    //     proController.getMorePost(
    //       1,
    //       postData.geolat,
    //       postData.geolon,
    //     );
    //   }
    // }
    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      locationController.singlePostPromap.value = true;
    } else {
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        locationController.singlePostPromap.value = false;
      }
    }
  }

  var lodingPage = 2;
  void _scrollListenerMore() {
    if (_controllerMore.position.pixels ==
            _controllerMore.position.maxScrollExtent &&
        proController.lodingmorePosts.value == false) {
      print("Lode More Page");
      proController.getMorePost(
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
  }

  // ignore: unused_field
  late String _mapStyle;
  Set<Marker> markers = {};
  void addMarker() async {
    await markers.addLabelMarker(
      LabelMarker(
        label: postData.price == 0
            ? "call for price"
            : "৳ ${userController.currency(postData.price)}",
        // label: data.rent.toString(),
        markerId: MarkerId(postData.pid.toString()),
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

  UserController userController = Get.find();

  var height = Get.height;
  var width = Get.width;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    double space = 20.0;
    return Obx(
      () => proController.singlePostloding.value
          ? const SinglePostShimmer() //! Work here
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
                        SizedBox(width: space),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              final call = Uri.parse('tel:${postData.phone}');
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
                              // ignore: prefer__ructors
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                  'sms:${postData.phone}?body=hello%20there');
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
                                // color:  Color(0xff27D468),
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
                              String phone = postData.wapp;
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
                        SizedBox(width: space),
                      ],
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  SizedBox(height: 20),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    const SizedBox(width: 10),
                                    LikeButton(
                                      size: 32,
                                      likeBuilder: (bool isLiked) {
                                        return Icon(
                                          isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color: isLiked
                                              ? Colors.lightBlue
                                              : const Color(0xff083437),
                                        );
                                      },
                                      animationDuration:
                                          const Duration(milliseconds: 400),
                                      onTap: (isLiked) async {
                                        print(!isLiked);
                                        proController.savePost(
                                          postData.pid,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: space),
                        // Padding(
                        //   padding:  EdgeInsets.only(left: 20, right: 20),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: postData.price == 0
                                    ? const Text(
                                        'Call For Price',
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                        ),
                                      )
                                    : Text(
                                        // currency(
                                        //   singlepost.price,
                                        //   '৳',
                                        // ),
                                        "BDT ${userController.currency(postData.price)} ",
                                        // "${NumberFormat.decimalPattern().format(singlepost.price)} BDT",
                                        style: const TextStyle(
                                          fontSize: 28,
                                          color: Color(0xff083437),
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                              ),
                            ),
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Feather.share_2,
                                  color: Color(0xff083437),
                                  size: 22,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),

                        SizedBox(height: space),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
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
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {},
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
                                            padding: const EdgeInsets.all(10.0),
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
                                    Text(
                                      postData.location,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff083437),
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${userController.getDay(postData.time)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff083437),
                                  fontWeight: FontWeight.normal,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: space),
                              postData.category == category[2] ||
                                      postData.category == category[3]
                                  ? Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/bed.svg',
                                                title: postData.area,
                                                subtitle: postData.measurement,
                                                iconheight: 32,
                                                iconwidth: 32,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/size.svg',
                                                title: "Rode Size",
                                                subtitle: postData.roadSize,
                                                iconheight: 32,
                                                iconwidth: 32,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/bed.svg',
                                                title: 'Beds',
                                                subtitle: postData.bed,
                                                iconheight: 32,
                                                iconwidth: 32,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/bath.svg',
                                                title: 'Baths',
                                                subtitle: postData.bath,
                                                iconheight: 31,
                                                iconwidth: 31,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/kitchen.svg',
                                                title: 'Kitchen',
                                                subtitle: postData.kitchen,
                                                iconheight: 30,
                                                iconwidth: 30,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/dining.svg',
                                                title: 'Dining',
                                                subtitle: postData.dining,
                                                iconheight: 34,
                                                iconwidth: 34,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: space),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/size.svg',
                                                title: 'Size',
                                                subtitle: postData.size,
                                                iconheight: 29,
                                                iconwidth: 29,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/window.svg',
                                                title: 'Facing',
                                                subtitle: postData.facing,
                                                iconheight: 30,
                                                iconwidth: 30,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/floor.svg',
                                                title: 'Total Floor',
                                                subtitle: postData.totalFloor,
                                                iconheight: 28,
                                                iconwidth: 28,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/floorno.svg',
                                                title: 'Floor No.',
                                                subtitle:
                                                    postData.floornumber, //3rd
                                                iconheight: 28,
                                                iconwidth: 28,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: space),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/floorplan.svg',
                                                title: 'Total Unit',
                                                subtitle: postData.totalUnit,
                                                iconheight: 25,
                                                iconwidth: 25,
                                              ),
                                              const DetailsCircle(
                                                icon:
                                                    'assets/icons/property/emi.svg',
                                                title: 'EMI',
                                                subtitle: 'YES',
                                                iconheight: 30,
                                                iconwidth: 30,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/new.svg',
                                                title: 'Condition',
                                                subtitle: postData.procondition,
                                                iconheight: 30,
                                                iconwidth: 30,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/users.svg',
                                                title: 'Posted by',
                                                subtitle: postData.ownertype,
                                                iconheight: 28,
                                                iconwidth: 28,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                              postData.category == category[0] ||
                                      postData.category == category[1]
                                  ? const SizedBox()
                                  : const SizedBox(height: 15),

                              SizedBox(height: space),
                              Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              SizedBox(height: space),
                              const Text(
                                'Amenities',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // First Column
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: () {
                                            List<String> amenitiesList =
                                                List<String>.from(
                                              json.decode(
                                                postData.amenities,
                                              ),
                                            );

                                            int halfLength =
                                                (amenitiesList.length / 2)
                                                    .ceil();

                                            return List.generate(
                                              halfLength,
                                              (index) => Amenities(
                                                text: amenitiesList[index],
                                              ),
                                            );
                                          }(),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Second Column
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: () {
                                            List<String> amenitiesList =
                                                List<String>.from(
                                              json.decode(
                                                postData.amenities,
                                              ),
                                            );

                                            int halfLength =
                                                (amenitiesList.length / 2)
                                                    .ceil();
                                            int start = halfLength;

                                            return List.generate(
                                              amenitiesList.length - halfLength,
                                              (index) => Amenities(
                                                text: amenitiesList[
                                                    start + index],
                                              ),
                                            );
                                          }(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Text(
                              //   'Text Here',
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //     color: Colors.black,
                              //   ),
                              // ),
                              //  Padding(
                              //   padding: EdgeInsets.only(
                              //     left: 10,
                              //     top: 10,
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.start,
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Amenities(text: 'Balcony'),
                              //           Amenities(text: 'Parking'),
                              //           Amenities(text: 'CCTV'),
                              //           Amenities(text: 'GAS'),
                              //           Amenities(text: 'ELEVATOR'),
                              //           Amenities(text: 'Security Guard'),
                              //           Amenities(text: 'Power Backup'),
                              //         ],
                              //       ),
                              //       Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.start,
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Amenities(text: 'Fire Alarm'),
                              //           Amenities(text: 'Fire exit'),
                              //           Amenities(text: 'Gaser'),
                              //           Amenities(text: 'Wasa Connection'),
                              //           Amenities(text: 'West Disposal'),
                              //           Amenities(text: 'Garden'),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              postData.floorPlan == ""
                                  ? const SizedBox()
                                  : SizedBox(height: space),
                              postData.floorPlan == ""
                                  ? const SizedBox()
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.blueAccent),
                                      ),
                                      child: ExpandablePanel(
                                        header: Container(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            bottom: 10,
                                          ),
                                          child: const Text(
                                            'Floor Plan',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        collapsed: const SizedBox(),
                                        expanded: Container(
                                          height: 300,
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: MemoryImage(
                                                base64Decode(
                                                  postData.floorPlan,
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(height: space),
                              postData.ytVideo == ""
                                  ? const SizedBox()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Video',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            // fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        SizedBox(height: space),
                                        YoutubeVideo(
                                          videoUrl: postData.ytVideo,
                                        ),
                                      ],
                                    ),
                              SizedBox(height: space),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
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
                                  Text(
                                    'id: ${postData.pid}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: space),
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
                                    postData.description,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.clip,
                                    // maxLines: 5,
                                  ),
                                ),
                              ),
                              SizedBox(height: space),
                              const Text(
                                "In Map",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff083437),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: space),
                              // Container(
                              //   height: 100,
                              //   decoration: BoxDecoration(
                              //     color: Colors.red,
                              //     borderRadius: BorderRadius.circular(6),
                              //     image:  DecorationImage(
                              //       fit: BoxFit.cover,
                              //       image: NetworkImage(
                              //         "https://media.wired.com/photos/59269cd37034dc5f91bec0f1/master/w_1920,c_limit/GoogleMapTA.jpg",
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                height: 130,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
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
                                        // mapType: MapType.normal,
                                        zoomControlsEnabled: false,
                                        myLocationButtonEnabled: false,
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                            double.parse(postData.geolat),
                                            double.parse(postData.geolon),
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
                                          child: FloatingActionButton.extended(
                                            backgroundColor: Colors.blue,
                                            onPressed: () async {
                                              final coords = Coords(
                                                double.parse(postData.geolat),
                                                double.parse(postData.geolon),
                                              );
                                              var title =
                                                  "Price ৳ ${userController.currency(postData.price)}";
                                              final availableMaps =
                                                  await MapLauncher
                                                      .installedMaps;
                                              print(availableMaps.length);
                                              if (availableMaps.length == 1) {
                                                await availableMaps.first
                                                    .showMarker(
                                                  coords: coords,
                                                  title: title,
                                                  description: "description",
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
                                                                coords: coords,
                                                                title: title,
                                                              ),
                                                              title: Text(
                                                                  map.mapName),
                                                              leading:
                                                                  SvgPicture
                                                                      .asset(
                                                                map.icon,
                                                                height: 30.0,
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

                              SizedBox(height: space),
                              Details(
                                type: "Short Address",
                                detailstext: postData.shortaddress,
                                icon: Icons.share_location_rounded,
                              ),
                              // Container(
                              //   height: 100,
                              //   width: width,
                              //   decoration: BoxDecoration(
                              //     color: Colors.black12,
                              //     borderRadius: BorderRadius.circular(10),
                              //   ),
                              //   child:  Text(
                              //     "Nirala 14, Khulna",
                              //     style: TextStyle(
                              //       fontSize: 12,
                              //       color: Color(0xff083437),
                              //       fontWeight: FontWeight.normal,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: space),
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
                    SizedBox(height: space),
                    SizedBox(
                      height: height / 7,
                      child: StreamBuilder(
                        stream: proController.morePost.stream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return const PostListSuggstionSimmer(
                              topPadding: 0,
                              count: 4,
                            );
                          } else {
                            return ListView.builder(
                              controller: _controllerMore,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length + 1,
                              itemBuilder: (c, i) {
                                if (i < snapshot.data.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.1),
                                          width: 0.4,
                                        ),
                                      ),
                                      child: MorePostsPro(
                                        postData: snapshot.data[i],
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                    // SizedBox(
                    //   height: 120,
                    //   child: SizedBox(
                    //     height: 120,
                    //     child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: 10,
                    //       itemBuilder: (context, index) {
                    //         return Padding(
                    //           padding: const EdgeInsets.only(left: 20),
                    //           child: Container(
                    //             width: Get.width / 1.4,
                    //             decoration: BoxDecoration(
                    //               color: Colors.red,
                    //               borderRadius: BorderRadius.circular(10),
                    //               border: Border.all(
                    //                 color: Colors.black12,
                    //                 width: 1,
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 140),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Amenities extends StatelessWidget {
  final String text;
  const Amenities({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 14,
            width: 14,
            child: SvgPicture.asset(
              'assets/icons/property/check.svg',
              colorFilter: const ColorFilter.mode(
                Colors.blue,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.7),
              height: 1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsCircle extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final double iconheight;
  final double iconwidth;

  const DetailsCircle(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.iconheight,
      required this.iconwidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            // color: Colors.blue.shade50.withOpacity(0.6),
            color: const Color(0xffFFE7CC).withOpacity(0.2),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: SizedBox(
              height: iconheight,
              width: iconwidth,
              child: SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  // Colors.blue[600]!,
                  Colors.black.withOpacity(0.7),
                  // Colors.blue,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class DetailsProperty extends StatelessWidget {
  final String type;
  final String detailstext;
  final IconData icon;
  final Color textColor;

  const DetailsProperty({
    super.key,
    required this.type,
    required this.detailstext,
    required this.icon,
    this.textColor = const Color(0xff083437),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class YoutubeVideo extends StatefulWidget {
  final String videoUrl;
  const YoutubeVideo({super.key, required this.videoUrl});

  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  // var videoUrl = "6KLSz3owo20";
  // ignore: prefer_typing_uninitialized_variables
  var _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(widget.videoUrl)!,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
      ),
    );
    // _controller = YoutubePlayerController.fromVideoId(
    //   videoId: videoUrl,
    //   autoPlay: false,
    //   params:  YoutubePlayerParams(
    //     showFullscreenButton: true,
    //   ),
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 200,
        width: Get.width,
        child: YoutubePlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
          enableFullScreenOnVerticalDrag: true,
        ),
      ),
    );
  }
}
