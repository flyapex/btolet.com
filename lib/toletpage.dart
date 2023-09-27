import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ToletPage extends StatelessWidget {
  const ToletPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60,
        width: width,
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
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
                      ),
                      // SizedBox(width: 10),
                      // Text(
                      //   'Call',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
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
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      // Text(
                      //   'Wapp',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
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
                      Icons.person_pin_circle_rounded,
                      color: Colors.white,
                    ),
                    // SizedBox(width: 10),
                    // Text(
                    //   'Support',
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 20),
              Container(
                height: height / 4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1501183638710-841dd1904471?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
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
                              'https://images.unsplash.com/photo-1501183638710-841dd1904471?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "৳ 2000",
                              style: TextStyle(
                                fontSize: 24,
                                color: Color(0xff083437),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  child: const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Feather.share_2,
                                      color: Color(0xff083437),
                                      size: 22,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
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
                              ],
                            ),
                          ],
                        ),
                        const Text(
                          "tolet In Khulna, Nirala 14 | tolet In Khulna, Nirala 14 Nirala",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff083437),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
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
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nirala 14, Khulna",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff083437),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
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
                  Container(
                    height: 20,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                    ),
                  ),
                  // const SizedBox(height: 20),
                  // Container(
                  //   height: 100,
                  //   width: width,
                  //   decoration: BoxDecoration(
                  //     color: Colors.yellow,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: const Center(
                  //     child: Text('Ads'),
                  //   ),
                  // ),
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
                        const SizedBox(height: 10),
                        const Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff083437),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Details(
                          type: "Property Type",
                          detailstext: "Family, Bachelor",
                          icon: Icons.business_outlined,
                        ),
                        const SizedBox(height: 15),
                        const Details(
                          type: "Bedrooms",
                          detailstext: "5",
                          icon: Icons.bedroom_parent_outlined,
                        ),
                        const SizedBox(height: 15),
                        const Details(
                          type: "Bathrooms",
                          detailstext: "2",
                          icon: Icons.bathtub_outlined,
                        ),
                        const SizedBox(height: 15),
                        const Details(
                          type: "Dining",
                          detailstext: "2",
                          icon: Icons.dining_outlined,
                        ),
                        const SizedBox(height: 15),
                        const Details(
                          type: "Kitchen",
                          detailstext: "1",
                          icon: Icons.kitchen_rounded,
                        ),
                        const SizedBox(height: 15),
                        const Details(
                          type: "Room Size",
                          detailstext: "450 m\u00b2(4,849 ft\u00b2)",
                          icon: Icons.all_inclusive_rounded,
                        ),
                        const SizedBox(height: 15),
                        const Details(
                          type: "Floor",
                          detailstext: "3rd",
                          icon: Icons.person_pin_circle_rounded,
                        ),
                        const SizedBox(height: 15),
                        const Details(
                          type: "Facing",
                          detailstext: "North",
                          icon: Icons.window_outlined,
                        ),
                        const SizedBox(height: 15),
                        const Details(
                          type: "Fasilities",
                          detailstext: "Lift , Car Parking",
                          icon: Icons.search_sharp,
                          textColor: Colors.green,
                        ),
                        const SizedBox(height: 15),
                        const Details(
                          type: "Mentanence",
                          detailstext: "300 ৳/mon",
                          icon: Icons.monetization_on_outlined,
                        ),

                        const SizedBox(height: 15),
                        const Details(
                          type: "Rent From",
                          detailstext: "19-10-2023",
                          icon: Icons.access_time,
                        ),
                        const SizedBox(height: 15),
                        const Details(
                          type: "Short Address",
                          detailstext: "Nirala scool, 334 no building",
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Feather.menu,
                              color: const Color(0xff8595A9).withOpacity(0.5),
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
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffE3E8FF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Nirala 14, Khulna",
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
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
                        const SizedBox(height: 200),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
