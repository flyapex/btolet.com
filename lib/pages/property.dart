import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:like_button/like_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'tolet.dart';

class PropertyPage extends StatelessWidget {
  const PropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Note(),
            const SizedBox(height: 20),
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1916&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
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
                Container(
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
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1501183638710-841dd1904471?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
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
                              'https://images.unsplash.com/photo-1501183638710-841dd1904471?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
                          fit: BoxFit.cover,
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
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "৳ 2000 ",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff083437),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
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
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.chair_outlined,
                      size: 16,
                      color: Colors.black45,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "3",
                      style: TextStyle(
                        color: Color(0xff083437),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.shower_outlined,
                      size: 16,
                      color: Colors.black45,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "2",
                      style: TextStyle(
                        color: Color(0xff083437),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.all_inclusive,
                      size: 16,
                      color: Colors.black45,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "3 m",
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
