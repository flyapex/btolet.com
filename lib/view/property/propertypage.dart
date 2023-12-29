import 'dart:convert';
import 'dart:io';
import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/home/shimmer/shimmer.dart';
import 'package:btolet/view/tolet/toletpage.dart';
import 'package:expandable/expandable.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:timeago/timeago.dart' as timeago;

class PropertyPage extends StatefulWidget {
  final int pid;
  const PropertyPage({super.key, required this.pid});

  @override
  State<PropertyPage> createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  PostController postController = Get.find();
  lodeData() async {
    var data = await postController.getSinglePostProperty(widget.pid);
    if (data) {
      addMarker();
    }
  }

  @override
  void initState() {
    lodeData();
    rootBundle.loadString('assets/map/map_style.txt').then((string) {
      _mapStyle = string;
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ignore: unused_field
  late String _mapStyle;
  Set<Marker> markers = {};
  void addMarker() async {
    await markers.addLabelMarker(
      LabelMarker(
        label:
            "৳ ${NumberFormat.decimalPattern().format(postController.singlepostProperty.price)}",
        // label: data.rent.toString(),
        markerId: MarkerId(postController.singlepostProperty.pid.toString()),
        position: LatLng(double.parse(postController.singlepostProperty.geolat),
            double.parse(postController.singlepostProperty.geolon)),
        backgroundColor: Colors.orange,
        infoWindow: InfoWindow(
          title:
              '${postController.singlepostProperty.bed}bed,${postController.singlepostProperty.bath}bath,${postController.singlepostProperty.kitchen}kitchen',
        ),
        onTap: () async {},
      ),
    );

    setState(() {});
  }

  UserController userController = Get.find();

  String currency(int amount, String symbol) {
    convertToBengaliDigits(val) {
      return userController.convertToBengaliDigits(val);
    }

    if (amount >= 10000000) {
      final crorePart = (amount / 10000000).floor();
      final lakhPart = (amount % 10000000) ~/ 100000;
      final thousandPart = (amount % 100000) ~/ 1000;

      String formattedAmount =
          '$symbol ${convertToBengaliDigits(crorePart)} কোটি';

      if (lakhPart > 0) {
        formattedAmount += ' ${convertToBengaliDigits(lakhPart)} লাখ';
      }

      if (thousandPart > 0) {
        formattedAmount += ' ${convertToBengaliDigits(thousandPart)} হাজার';
      }

      return formattedAmount;
    } else if (amount >= 100000) {
      final lakhPart = (amount / 100000).floor();
      final thousandPart = (amount % 100000) ~/ 1000;

      String formattedAmount =
          '$symbol ${convertToBengaliDigits(lakhPart)} লাখ';

      if (thousandPart > 0) {
        formattedAmount += ' ${convertToBengaliDigits(thousandPart)} হাজার';
      }

      return formattedAmount;
    } else {
      return '$symbol ${convertToBengaliDigits(amount)}';
    }
  }

  var height = Get.height;
  var width = Get.width;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => postController.singlepostPropertyloding.value
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
                              final call = Uri.parse('tel:01612217208');
                              if (await canLaunchUrl(call)) {
                                launchUrl(call);
                              } else {
                                throw 'Could not launch $call';
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                // left: 11,
                                // right: 11,
                                bottom: 9,
                                top: 9,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
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
                              const uri =
                                  'sms:+8801612217208?body=hello%20there';
                              // ignore: deprecated_member_use
                              if (await canLaunch(uri)) {
                                // ignore: deprecated_member_use
                                await launch(uri);
                              } else {
                                // iOS
                                const uri =
                                    'sms:8801612217208?body=hello%20there';
                                // ignore: deprecated_member_use
                                if (await canLaunch(uri)) {
                                  // ignore: deprecated_member_use
                                  await launch(uri);
                                } else {
                                  throw 'Could not launch $uri';
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                // left: 11,
                                // right: 11,
                                bottom: 9,
                                top: 9,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.message,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
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
                            child: Container(
                              padding: const EdgeInsets.only(
                                // left: 11,
                                // right: 11,
                                bottom: 9,
                                top: 9,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 26,
                                    width: 26,
                                    child: SvgPicture.asset(
                                      'assets/icons/wapp.svg',
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
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 20),
                    Stack(
                      children: [
                        ImageSlidePage(
                          hight: height / 3.5,
                          imageList: postController.imageListPro,
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
                        const SizedBox(height: 20),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20, right: 20),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  // currency(
                                  //   postController.singlepostProperty.price,
                                  //   '৳',
                                  // ),
                                  "${NumberFormat.decimalPattern().format(postController.singlepostProperty.price)} BDT",
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

                        const SizedBox(height: 20),
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
                                                'assets/icons/map.svg',
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
                                        postController
                                            .singlepostProperty.location,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff083437),
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                ' ${timeago.format(postController.singlepostProperty.time, locale: 'en_short')} ago',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff083437),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              postController.singlepostProperty.propertyType ==
                                      2
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
                                                title: postController
                                                    .singlepostProperty.area,
                                                subtitle: postController
                                                    .singlepostProperty
                                                    .measurementProperty,
                                                iconheight: 32,
                                                iconwidth: 32,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/size.svg',
                                                title: "Rode Size",
                                                subtitle: postController
                                                    .singlepostProperty
                                                    .roadSize,
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
                                                subtitle: postController
                                                    .singlepostProperty.bed,
                                                iconheight: 32,
                                                iconwidth: 32,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/bath.svg',
                                                title: 'Baths',
                                                subtitle: postController
                                                    .singlepostProperty.bath,
                                                iconheight: 31,
                                                iconwidth: 31,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/kitchen.svg',
                                                title: 'Kitchen',
                                                subtitle: postController
                                                    .singlepostProperty.kitchen,
                                                iconheight: 30,
                                                iconwidth: 30,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/dining.svg',
                                                title: 'Dining',
                                                subtitle: postController
                                                    .singlepostProperty.dining,
                                                iconheight: 34,
                                                iconwidth: 34,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/size.svg',
                                                title: 'Size',
                                                subtitle: postController
                                                    .singlepostProperty.size,
                                                iconheight: 29,
                                                iconwidth: 29,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/window.svg',
                                                title: 'Facing',
                                                subtitle: postController
                                                    .singlepostProperty.facing,
                                                iconheight: 30,
                                                iconwidth: 30,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/floor.svg',
                                                title: 'Total Floor',
                                                subtitle: postController
                                                    .singlepostProperty
                                                    .totalFloor,
                                                iconheight: 28,
                                                iconwidth: 28,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/floorno.svg',
                                                title: 'Floor No.',
                                                subtitle: postController
                                                    .singlepostProperty
                                                    .floornumber, //3rd
                                                iconheight: 28,
                                                iconwidth: 28,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/floorplan.svg',
                                                title: 'Total Unit',
                                                subtitle: postController
                                                    .singlepostProperty
                                                    .totalUnit,
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
                                                subtitle: postController
                                                    .singlepostProperty
                                                    .propertycondition,
                                                iconheight: 30,
                                                iconwidth: 30,
                                              ),
                                              DetailsCircle(
                                                icon:
                                                    'assets/icons/property/users.svg',
                                                title: 'Posted by',
                                                subtitle: postController
                                                    .singlepostProperty
                                                    .ownertype,
                                                iconheight: 28,
                                                iconwidth: 28,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                              postController.singlepostProperty.propertyType ==
                                      2
                                  ? const SizedBox()
                                  : const SizedBox(height: 15),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     const Text(
                              //       "Details",
                              //       style: TextStyle(
                              //         fontSize: 16,
                              //         color: Color(0xff083437),
                              //         fontWeight: FontWeight.normal,
                              //       ),
                              //     ),
                              //     Text(
                              //       "ID:1200",
                              //       style: TextStyle(
                              //         fontSize: 12,
                              //         color: const Color(0xff083437).withOpacity(0.7),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              // const DetailsProperty(
                              //   type: "Property Type",
                              //   detailstext: "Flat",
                              //   icon: Icons.business_outlined,
                              // ),
                              // const SizedBox(height: 15),
                              // const DetailsProperty(
                              //   type: "Condition",
                              //   detailstext: "New or Under Construction",
                              //   icon: Icons.construction_outlined,
                              // ),
                              // const SizedBox(height: 20),
                              // const DetailsProperty(
                              //   type: "EMI",
                              //   detailstext: "Yes",
                              //   icon: Icons.monetization_on_outlined,
                              // ),
                              // const SizedBox(height: 20),
                              // const DetailsProperty(
                              //   type: "Property Size",
                              //   detailstext: "1,350 ",
                              //   icon: Icons.share_location_rounded,
                              // ),
                              const SizedBox(height: 20),
                              Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 20),
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
                                                postController
                                                    .singlepostProperty
                                                    .amenities,
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
                                                postController
                                                    .singlepostProperty
                                                    .amenities,
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
                              // const Padding(
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

                              postController.singlepostProperty.floorPlan == ""
                                  ? const SizedBox()
                                  : const SizedBox(height: 20),
                              postController.singlepostProperty.floorPlan == ""
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
                                                  postController
                                                      .singlepostProperty
                                                      .floorPlan,
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 20),
                              postController.singlepostProperty.ytVideo == ""
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        const Text(
                                          'Video',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            // fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        YoutubeVideo(
                                          videoUrl: postController
                                              .singlepostProperty.ytVideo,
                                        ),
                                      ],
                                    ),
                              const SizedBox(height: 20),
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
                                    'id: ${postController.singlepostProperty.pid}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
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
                                    postController
                                        .singlepostProperty.description,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.clip,
                                    // maxLines: 5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "propertyed In",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff083437),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Container(
                              //   height: 100,
                              //   decoration: BoxDecoration(
                              //     color: Colors.red,
                              //     borderRadius: BorderRadius.circular(6),
                              //     image: const DecorationImage(
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
                                    GoogleMap(
                                      onMapCreated: (controller) {
                                        controller.setMapStyle(_mapStyle);
                                      },
                                      // mapType: MapType.normal,
                                      zoomControlsEnabled: false,
                                      myLocationButtonEnabled: false,
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                          double.parse(postController
                                              .singlepostProperty.geolat),
                                          double.parse(postController
                                              .singlepostProperty.geolon),
                                        ),
                                        zoom: 16.0,
                                      ),
                                      mapToolbarEnabled: false,
                                      markers: markers,
                                      compassEnabled: true,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          onTap: () async {
                                            final coords = Coords(
                                              double.parse(postController
                                                  .singlepostProperty.geolat),
                                              double.parse(postController
                                                  .singlepostProperty.geolon),
                                            );
                                            var title =
                                                "Price ৳ ${NumberFormat.decimalPattern().format(postController.singlepostProperty.price)}";
                                            final availableMaps =
                                                await MapLauncher.installedMaps;
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
                                                  child: SingleChildScrollView(
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
                                                            title: Text(
                                                                map.mapName),
                                                            leading: SvgPicture
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
                                          child: const CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.blue,
                                            child: Icon(
                                              // Icons.turn_right,
                                              Feather.navigation,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),
                              Details(
                                type: "Short Address",
                                detailstext: postController
                                    .singlepostProperty.shortaddress,
                                icon: Icons.share_location_rounded,
                              ),
                              // Container(
                              //   height: 100,
                              //   width: width,
                              //   decoration: BoxDecoration(
                              //     color: Colors.black12,
                              //     borderRadius: BorderRadius.circular(10),
                              //   ),
                              //   child: const Text(
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
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'more',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 120,
                      child: SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                width: Get.width / 1.4,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 1,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 140),
                  ],
                ),
              ),
            ),
    );
  }
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
    //   params: const YoutubePlayerParams(
    //     showFullscreenButton: true,
    //   ),
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: Get.width,
      child: YoutubePlayer(
        controller: _controller,
        aspectRatio: 16 / 9,
        enableFullScreenOnVerticalDrag: true,
      ),
    );
  }
}
