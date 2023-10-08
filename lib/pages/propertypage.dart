import 'dart:io';
import 'dart:ui';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PropertyPage extends StatefulWidget {
  const PropertyPage({super.key});

  @override
  State<PropertyPage> createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  var height = Get.height;
  var width = Get.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                      const uri = 'sms:+8801612217208?body=hello%20there';
                      // ignore: deprecated_member_use
                      if (await canLaunch(uri)) {
                        // ignore: deprecated_member_use
                        await launch(uri);
                      } else {
                        // iOS
                        const uri = 'sms:8801612217208?body=hello%20there';
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
                Container(
                  height: height / 3.5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1533280385001-c32ffcbd52a7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1533280385001-c32ffcbd52a7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
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
                                        : Icons.favorite_border_outlined,
                                    color: isLiked
                                        ? Colors.lightBlue
                                        : Colors.white);
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
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "৳ 2.12 Lak",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xff083437),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //       const SizedBox(height: 10),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           Row(
                //             crossAxisAlignment: CrossAxisAlignment.end,
                //             children: [
                //               SizedBox(
                //                 height: 30,
                //                 width: 30,
                //                 child: SvgPicture.asset(
                //                   'assets/icons/bed.svg',
                //                   colorFilter: const ColorFilter.mode(
                //                     Color(0xff083437),
                //                     BlendMode.srcIn,
                //                   ),
                //                 ),
                //               ),
                //               const SizedBox(width: 10),
                //               const Text(
                //                 '3 Beds',
                //                 style: TextStyle(
                //                   color: Color(0xff083437),
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 16,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           const SizedBox(width: 20),
                //           Row(
                //             crossAxisAlignment: CrossAxisAlignment.end,
                //             children: [
                //               SizedBox(
                //                 height: 28,
                //                 width: 28,
                //                 child: SvgPicture.asset(
                //                   'assets/icons/bath.svg',
                //                   colorFilter: const ColorFilter.mode(
                //                     Color(0xff083437),
                //                     BlendMode.srcIn,
                //                   ),
                //                 ),
                //               ),
                //               const SizedBox(width: 10),
                //               const Text(
                //                 '3 Baths',
                //                 style: TextStyle(
                //                   color: Color(0xff083437),
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 16,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           const SizedBox(width: 20),
                //           Row(
                //             crossAxisAlignment: CrossAxisAlignment.end,
                //             children: [
                //               SizedBox(
                //                 height: 20,
                //                 width: 20,
                //                 child: SvgPicture.asset(
                //                   'assets/icons/size.svg',
                //                   colorFilter: const ColorFilter.mode(
                //                     Color(0xff083437),
                //                     BlendMode.srcIn,
                //                   ),
                //                 ),
                //               ),
                //               const SizedBox(width: 10),
                //               const Text(
                //                 '1,350 (ft\u00b2)',
                //                 style: TextStyle(
                //                   color: Color(0xff083437),
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 16,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
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
                        onTap: () async {
                          var lat = 22.789698;
                          var lng = 89.559075;
                          MapsLauncher.launchCoordinates(lat, lng);
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
                                  borderRadius: BorderRadius.circular(100),
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
                              child: const Text(
                                // locationController.locationAddress.value,
                                "khulna, Nirala",
                                style: TextStyle(
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
                      const Text(
                        "10 days ago",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff083437),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   height: 20,
                //   margin: const EdgeInsets.only(top: 10),
                //   decoration: const BoxDecoration(
                //     color: Colors.black12,
                //   ),
                //   // child: const Row(
                //   //   children: [
                //   //     Text(
                //   //       "tolet In Khulna, Nirala 14 Nirala",
                //   //       style: TextStyle(
                //   //         fontSize: 16,
                //   //         color: Color(0xff083437),
                //   //         fontWeight: FontWeight.normal,
                //   //         overflow: TextOverflow.clip,
                //   //       ),
                //   //     ),
                //   //   ],
                //   // ),
                // ),
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
                // Container(
                //   height: 1,
                //   decoration: BoxDecoration(
                //     color: Colors.black12,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 10),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: const Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.spaceBetween,
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              DetailsCircle(
                                icon: 'assets/icons/property/bed.svg',
                                title: 'Beds',
                                subtitle: '2',
                              ),
                              DetailsCircle(
                                icon: 'assets/icons/property/bath.svg',
                                title: 'Baths',
                                subtitle: '1',
                              ),
                              DetailsCircle(
                                icon: 'assets/icons/property/size.svg',
                                title: 'Size',
                                subtitle: '1,350 (ft\u00b2)',
                              ),
                              DetailsCircle(
                                icon: 'assets/icons/property/users.svg',
                                title: 'I am',
                                subtitle: 'Agent',
                              ),
                              DetailsCircle(
                                icon: 'assets/icons/property/kitchen.svg',
                                title: 'Kitchen',
                                subtitle: '2',
                              ),
                              DetailsCircle(
                                icon: 'assets/icons/property/dining.svg',
                                title: 'Dining',
                                subtitle: '2',
                              ),
                              DetailsCircle(
                                icon: 'assets/icons/property/window.svg',
                                title: 'Facing',
                                subtitle: 'North',
                              ),
                              DetailsCircle(
                                icon: 'assets/icons/property/floor.svg',
                                title: 'Floor',
                                subtitle: '12th',
                              ),
                              DetailsCircle(
                                icon: 'assets/icons/property/floor.svg',
                                title: 'Floor No.',
                                subtitle: '3rd',
                              ),
                              DetailsCircle(
                                icon: 'assets/icons/property/floorplan.svg',
                                title: 'Unit',
                                subtitle: '3',
                              ),
                              DetailsCircle(
                                icon: 'assets/icons/property/emi.svg',
                                title: 'EMI',
                                subtitle: 'YES',
                              ),
                              DetailsCircle(
                                icon: 'assets/icons/property/new.svg',
                                title: 'Type',
                                subtitle: 'NEW',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
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
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          top: 10,
                        ),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Amenities(text: 'Balcony'),
                                  Amenities(text: 'Parking'),
                                  Amenities(text: 'CCTV'),
                                  Amenities(text: 'GAS'),
                                  Amenities(text: 'ELEVATOR'),
                                  Amenities(text: 'Security Guard'),
                                  Amenities(text: 'Power Backup'),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Amenities(text: 'Fire Alarm'),
                                  Amenities(text: 'Fire exit'),
                                  Amenities(text: 'Gaser'),
                                  Amenities(text: 'Wasa Connection'),
                                  Amenities(text: 'West Disposal'),
                                  Amenities(text: 'Garden'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: ExpandablePanel(
                          header: const Text(
                            'Floor Plan',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          collapsed: const SizedBox(),
                          expanded: Container(
                            height: 300,
                            width: width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://cubicasa-wordpress-uploads.s3.amazonaws.com/uploads/2019/07/simple-stylish.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Video',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                      const YoutubeVideo(),
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
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://media.wired.com/photos/59269cd37034dc5f91bec0f1/master/w_1920,c_limit/GoogleMapTA.jpg",
                            ),
                          ),
                        ),
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
                      const SizedBox(height: 20),
                      Container(
                        height: 100,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text('Ads'),
                        ),
                      ),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
              ],
            ),
          ],
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
    return Row(
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
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class DetailsCircle extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const DetailsCircle(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: const Color(0xffCBECFF),
            // color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: SvgPicture.asset(
                icon,
                colorFilter: const ColorFilter.mode(
                  Color(0xff0670AC),
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
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black38,
            fontWeight: FontWeight.bold,
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
  const YoutubeVideo({super.key});

  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  var videoUrl = "GzU8KqOY8YA";
  // ignore: prefer_typing_uninitialized_variables
  var _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoUrl,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
      ),
    );

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
