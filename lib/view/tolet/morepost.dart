import 'dart:convert';

import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/ads_controller.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/tolet_model.dart';
import 'package:btolet/view/tolet/single_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MoreTolet extends StatefulWidget {
  final PostListTolet postData;
  final bool isLikedvalue;
  const MoreTolet({
    super.key,
    required this.postData,
    this.isLikedvalue = false,
  });

  @override
  State<MoreTolet> createState() => MoreToletState();
}

class MoreToletState extends State<MoreTolet> {
  ToletController toletController = Get.find();
  UserController userController = Get.find();
  AdsController adsController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width;

    getCategory() {
      var catagory = widget.postData.category;
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
      height: 130,
      width: width / 1.35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12, width: 0.9),
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
                        const EdgeInsets.only(left: 10, right: 10, bottom: 5),
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
                          " ${((widget.postData.category).map((e) => e.toString()).toList()).join(', ')}",
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
     🏷️ ${widget.postData.category}
    💰Rent: ${widget.postData.rent} ৳
    📍Location: ${widget.postData.location}
    
Download our app(Btolet) now to discover more!🌟
Click Here To Download:
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
