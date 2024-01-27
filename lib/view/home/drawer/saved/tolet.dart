import 'dart:convert';

import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/tolet_model.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:btolet/view/tolet/single_post.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';

class SavedToletPage extends StatefulWidget {
  const SavedToletPage({super.key});

  @override
  State<SavedToletPage> createState() => _SavedToletPageState();
}

class _SavedToletPageState extends State<SavedToletPage>
    with AutomaticKeepAliveClientMixin {
  ToletController toletController = Get.find();
  final scrollController = ScrollController();

  @override
  void initState() {
    toletController.getSave();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("You're at the top.");
        } else {
          print("You're at the Bottom.");

          toletController.getSave();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    toletController.savedPage.value = 1;
    toletController.allSavedPost.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomRefreshIndicator(
        completeStateDuration: const Duration(milliseconds: 450),
        builder: MaterialIndicatorDelegate(
          backgroundColor: Colors.blueAccent,
          builder: (context, controller) {
            return SizedBox(
              child: LottieBuilder.asset(
                'assets/lottie/ref.json',
              ),
            );
          },
        ),
        onRefresh: () async {
          toletController.allSavedPost.clear();
          toletController.allSavedPost.refresh();
          toletController.savedPage.value = 1;
          toletController.allSavedPost();
          toletController.allSavedPost.sentToStream;
        },
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: StreamBuilder(
              stream: toletController.allSavedPost.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const PostListSimmer(
                    topPadding: 20,
                    count: 10,
                  );
                } else {
                  return AnimatedList(
                    key: toletController.deleteKeySaved,
                    controller: scrollController,
                    initialItemCount: toletController.allSavedPost.length,
                    itemBuilder: (context, i, animation) {
                      if (i < snapshot.data.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: PostsToletSaved(
                            postData: snapshot.data[i],
                            index: i,
                            isLikedvalue: true,
                          ),
                        );
                      } else {
                        if (toletController.savedPostloding.value) {
                          return const PostListSimmer(
                            topPadding: 20,
                            count: 10,
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('nothing more to load!'),
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
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PostsToletSaved extends StatefulWidget {
  final PostListTolet postData;
  final bool isLikedvalue;
  final int index;
  const PostsToletSaved({
    super.key,
    required this.postData,
    this.isLikedvalue = false,
    required this.index,
  });

  @override
  State<PostsToletSaved> createState() => _PostsToletSavedState();
}

class _PostsToletSavedState extends State<PostsToletSaved> {
  ToletController toletController = Get.find();
  UserController userController = Get.find();
  @override
  void initState() {
    // postController.singlepostTolet.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;

    return Container(
      height: height / 7,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, spreadRadius: 1.1),
        ],
        //  border: Border.all(color: Colors.black.withOpacity(0.1))
      ),
      child: Stack(
        // alignment: Alignment.centerRight,
        children: [
          InkWell(
            onTap: () {
              print(widget.postData.postId);
              Get.to(
                () => SinglePostTolet(postid: widget.postData.postId),
                transition: Transition.circularReveal,
                duration: const Duration(milliseconds: 600),
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
                        ),
                      ),
                    ),
                    //  widget.postData.totalImage == 1
                    // ? const SizedBox()
                    // :
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
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    // width: width - ((width / 2.8) + 40),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "৳ ${NumberFormat.decimalPattern().format(widget.postData.rent)}",
                            style: const TextStyle(
                              fontSize: 22,
                              color: Color(0xff083437),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          widget.postData.garagetype.isEmpty
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: SvgPicture.asset(
                                              'assets/icons/tolet/bed.svg',
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
                                            height: 18,
                                            width: 18,
                                            child: SvgPicture.asset(
                                              'assets/icons/tolet/bath.svg',
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                // Color(0xff083437),
                                                Colors.black87,
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
                                      child: widget.postData.roomsize == ''
                                          ? Row(
                                              children: [
                                                SizedBox(
                                                  height: 16,
                                                  width: 16,
                                                  child: SvgPicture.asset(
                                                    'assets/icons/tolet/kitchen.svg',
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                      // Color(0xff083437),
                                                      Colors.black87,
                                                      BlendMode.srcIn,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "  ${widget.postData.kitchen}",
                                                  style: const TextStyle(
                                                    color: Color(0xff083437),
                                                    fontSize: 14,
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
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                      // Color(0xff083437),
                                                      Colors.black87,
                                                      BlendMode.srcIn,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "  ${widget.postData.roomsize} ", //ft\u00b2
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
                                  ],
                                )
                              : widget.postData.garagetype == "Car"
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: SvgPicture.asset(
                                            'assets/icons/tolet/car.svg',
                                            colorFilter: const ColorFilter.mode(
                                              // Color(0xff083437),
                                              Colors.black87,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Text(
                                            " ${widget.postData.garagetype} Garage",
                                            style: const TextStyle(
                                              color: Color(0xff083437),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: SvgPicture.asset(
                                            'assets/icons/tolet/bike.svg',
                                            colorFilter: const ColorFilter.mode(
                                              // Color(0xff083437),
                                              Colors.black87,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          " ${widget.postData.garagetype} Garage",
                                          style: const TextStyle(
                                            color: Color(0xff083437),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                          const SizedBox(height: 6),
                          Text(
                            widget.postData.location,
                            style: TextStyle(
                              color: const Color(0xff083437).withOpacity(0.6),
                              fontSize: 12,
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
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // const Icon(
                //   Icons.favorite_border_outlined,
                //   color: Color(0xff083437),
                //   size: 26,
                // ),
                LikeButton(
                  size: 26,
                  isLiked: widget.isLikedvalue,
                  mainAxisAlignment: MainAxisAlignment.end,
                  circleColor: const CircleColor(
                    start: Color(0xff00ddff),
                    end: Color(0xff0099cc),
                  ),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  // likeCount: 665,
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border_outlined,
                      color:
                          isLiked ? Colors.blue.withOpacity(0.9) : Colors.grey,
                    );
                  },
                  animationDuration: const Duration(milliseconds: 400),
                  onTap: (isLiked) async {
                    PostListTolet removedItem =
                        toletController.allSavedPost.removeAt(widget.index);

                    toletController.deleteKeySaved.currentState!.removeItem(
                      widget.index,
                      (context, animation) => SlideTransition(
                        position: animation.drive(
                          Tween<Offset>(
                            begin: const Offset(2, 0.0),
                            end: const Offset(0.0, 0.0),
                          ).chain(
                            CurveTween(curve: Curves.easeIn),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: PostsToletSaved(
                            postData: removedItem,
                            index: widget.index,
                            isLikedvalue: false,
                          ),
                        ),
                      ),
                      duration: const Duration(
                        milliseconds: 600,
                      ),
                    );
                    toletController.save(
                      widget.postData.postId,
                      !isLiked,
                    );
                    return !isLiked;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  '${userController.getDay(widget.postData.time)}',
                  style: TextStyle(
                    color: const Color(0xff083437).withOpacity(0.3),
                    fontSize: 12,
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
