import 'dart:convert';

import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/pro_model.dart';
import 'package:btolet/view/property/single_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

class PostsProMap extends StatefulWidget {
  final MapProPostListModel postData;
  final bool isLikedvalue;
  const PostsProMap({
    super.key,
    required this.postData,
    this.isLikedvalue = false,
  });

  @override
  State<PostsProMap> createState() => _PostsProMapState();
}

class _PostsProMapState extends State<PostsProMap> {
  ProController proController = Get.find();
  UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          // height: height / 7,
          // width: Get.width / 1.2,
          height: 100,
          width: 300, margin: const EdgeInsets.only(bottom: 40, right: 28),
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
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: MemoryImage(
                                    base64Decode(widget.postData.image1)),
                                fit: BoxFit.cover,
                                // alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 4,
                              right: 4,
                              bottom: 4,
                            ),
                            child: SizedBox(
                              width: 44,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Material(
                                  color: Colors.black38,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                      bottom: 1,
                                      top: 1,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.postData.totalImage.toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
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
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.postData.price == 0
                                  ? const Text(
                                      'Call For Price',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(
                                      "${userController.currency(widget.postData.price)}",
                                      style: const TextStyle(
                                        fontSize: 22,
                                        color: Color(0xff083437),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              widget.postData.bed == ""
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              Text(
                                                widget.postData.measurement,
                                                style: const TextStyle(
                                                  color: Color(0xff083437),
                                                  fontSize: 18,
                                                  height: 1.2,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                widget.postData.area,
                                                style: const TextStyle(
                                                  color: Color(0xff083437),
                                                  fontSize: 19,
                                                  height: 1.2,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 18,
                                                width: 18,
                                                child: SvgPicture.asset(
                                                  'assets/icons/property/bed.svg',
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                    // Color(0xff083437),
                                                    Colors.black87,
                                                    // Colors.black87,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "  ${widget.postData.bed}",
                                                style: const TextStyle(
                                                  color: Color(0xff083437),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: SvgPicture.asset(
                                                  'assets/icons/property/bath.svg',
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                    // Color(0xff083437),
                                                    Colors.black87,
                                                    // Colors.black87,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "  ${widget.postData.bath}",
                                                style: const TextStyle(
                                                  color: Color(0xff083437),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 18,
                                                width: 18,
                                                child: SvgPicture.asset(
                                                  'assets/icons/property/size.svg',
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                    // Color(0xff083437),
                                                    Colors.black87,
                                                    // Colors.black87,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "  ${widget.postData.size}",
                                                  style: const TextStyle(
                                                    color: Color(0xff083437),
                                                    fontSize: 14,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       top: 2, bottom: 2),
                                        //   child: SizedBox(
                                        //     height: 22,
                                        //     width: 22,
                                        //     child: SvgPicture.asset(
                                        //       'assets/icons/property/bed.svg',
                                        //       colorFilter: ColorFilter.mode(
                                        //         Colors.black.withOpacity(0.5),
                                        //         BlendMode.srcIn,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        // const SizedBox(width: 6),
                                        // Text(
                                        //   widget.postData.bed,
                                        //   style: const TextStyle(
                                        //     color: Color(0xff083437),
                                        //   ),
                                        // ),
                                        // const SizedBox(width: 10),
                                        // SizedBox(
                                        //   height: 22,
                                        //   width: 22,
                                        //   child: SvgPicture.asset(
                                        //     'assets/icons/property/bath.svg',
                                        //     colorFilter: ColorFilter.mode(
                                        //       Colors.black.withOpacity(0.5),
                                        //       BlendMode.srcIn,
                                        //     ),
                                        //   ),
                                        // ),
                                        // const SizedBox(width: 6),
                                        // Text(
                                        //   widget.postData.bath,
                                        //   style: const TextStyle(
                                        //     color: Color(0xff083437),
                                        //   ),
                                        // ),
                                        // const SizedBox(width: 10),
                                        // SizedBox(
                                        //   height: 18,
                                        //   width: 18,
                                        //   child: SvgPicture.asset(
                                        //     'assets/icons/property/size.svg',
                                        //     colorFilter: ColorFilter.mode(
                                        //       Colors.black.withOpacity(0.5),
                                        //       BlendMode.srcIn,
                                        //     ),
                                        //   ),
                                        // ),
                                        // const SizedBox(width: 6),
                                        // Text(
                                        // widget.postData.size,
                                        // style: const TextStyle(
                                        //   color: Color(0xff083437),
                                        // ),
                                        // ),
                                      ],
                                    ),
                              const SizedBox(height: 6),
                              Text(
                                widget.postData.location,
                                style: TextStyle(
                                  color:
                                      const Color(0xff083437).withOpacity(0.6),
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
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
                padding: const EdgeInsets.only(right: 5, top: 5),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: LikeButton(
                      size: 26,
                      isLiked: widget.isLikedvalue,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.start,

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
                          isLiked
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: isLiked
                              ? Colors.blue.withOpacity(0.9)
                              : Colors.grey,
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
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
