import 'dart:convert';

import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/pro_model.dart';
import 'package:btolet/view/property/single_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

class PostsProMap extends StatefulWidget {
  final MapProPostListModel postData;
  final bool isLikedvalue;
  final double wid;
  final EdgeInsetsGeometry mar;
  const PostsProMap({
    super.key,
    required this.postData,
    this.isLikedvalue = false,
    required this.wid,
    required this.mar,
  });

  @override
  State<PostsProMap> createState() => _PostsProMapState();
}

class _PostsProMapState extends State<PostsProMap> {
  ProController proController = Get.find();
  UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    // var width = Get.width;
    return Container(
      // height: height / 7,
      // width: Get.width / 1.2,
      // height: 100,
      // width: 300, margin: const EdgeInsets.only(bottom: 40, right: 28),
      width: widget.wid,
      margin: widget.mar,
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
          GestureDetector(
            onTap: () {
              Get.to(
                () => SinglePostPro(pid: widget.postData.pid),
                transition: Transition.circularReveal,
                duration: const Duration(milliseconds: 600),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
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
                      // border: Border.all(color: Colors.black12, width: 0.9),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.postData.price == 0
                              ? const Text(
                                  'Price On Call',
                                  style: TextStyle(
                                    fontSize: s1,
                                    // height: 0.7,
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                )
                              : Text(
                                  "${userController.currency(widget.postData.price)} BDT",
                                  style: const TextStyle(
                                    fontSize: s1,
                                    height: 1,
                                    color: Color(0xff083437),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                          Text(
                            widget.postData.category,
                            style: const TextStyle(
                              height: 0.7,
                              color: Color(0xff083437),
                              fontSize: s4,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          // const SizedBox(height: 6),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 2,
                                  bottom: 2,
                                ),
                                child: SizedBox(
                                  height: 22,
                                  width: 22,
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
                              Text(
                                widget.postData.bed,
                                style: const TextStyle(
                                  fontSize: s3,
                                  color: Color(0xff083437),
                                ),
                              ).paddingOnly(bottom: 2),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 22,
                                width: 22,
                                child: SvgPicture.asset(
                                  'assets/icons/property/bath.svg',
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.5),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.postData.bath,
                                style: const TextStyle(
                                  fontSize: s3,
                                  color: Color(0xff083437),
                                ),
                              ).paddingOnly(bottom: 2),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 18,
                                width: 18,
                                child: SvgPicture.asset(
                                  'assets/icons/property/size.svg',
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.5),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  widget.postData.size,
                                  style: const TextStyle(
                                    fontSize: s3,
                                    color: Color(0xff083437),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ).paddingOnly(bottom: 2),
                              ),
                            ],
                          ),

                          // const SizedBox(height: 6),
                          Flexible(
                            child: Text(
                              widget.postData.location,
                              style: TextStyle(
                                color: const Color(0xff083437).withOpacity(0.6),
                                fontSize: 12,
                                fontFamily: 'Roboto',
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
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5, top: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 30,
                width: 30,
                child: LikeButton(
                  size: 26,
                  isLiked: widget.isLikedvalue,
                  circleColor: const CircleColor(
                    start: Color(0xff00ddff),
                    end: Color(0xff0099cc),
                  ),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border_outlined,
                      color:
                          isLiked ? Colors.blue.withOpacity(0.9) : Colors.grey,
                    );
                  },
                  animationDuration: const Duration(milliseconds: 400),
                  onTap: (isLiked) async {
                    print(!isLiked);
                    proController.savePost(
                      widget.postData.pid,
                      !isLiked,
                    );
                    return !isLiked;
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '${userController.getDay(widget.postData.time)}',
                style: TextStyle(
                  color: const Color(0xff083437).withOpacity(0.3),
                  height: 0.5,
                  fontSize: s4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
