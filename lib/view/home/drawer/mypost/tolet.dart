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
import 'package:lottie/lottie.dart';

class MyToletPage extends StatefulWidget {
  const MyToletPage({super.key});

  @override
  State<MyToletPage> createState() => _MyToletPageState();
}

class _MyToletPageState extends State<MyToletPage> {
  ToletController toletController = Get.find();
  final scrollController = ScrollController();

  @override
  void initState() {
    toletController.myPost();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("You're at the top.");
        } else {
          print("You're at the Bottom.");

          toletController.myPost();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    toletController.mypostPage.value = 1;
    toletController.mypostList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          toletController.mypostList.clear();
          toletController.mypostList.refresh();
          toletController.mypostPage.value = 1;
          toletController.myPost();
          toletController.mypostList.sentToStream;
        },
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: StreamBuilder(
              stream: toletController.mypostList.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const PostListSimmer(
                    topPadding: 20,
                    count: 10,
                  );
                } else {
                  return AnimatedList(
                    key: toletController.deleteKeyMypost,
                    controller: scrollController,
                    initialItemCount: toletController.mypostList.length,
                    padding: const EdgeInsets.only(bottom: 100),
                    itemBuilder: (context, i, animation) {
                      if (i < snapshot.data.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: MyPostsTolet(
                            postData: snapshot.data[i],
                            index: i,
                          ),
                        );
                      } else {
                        if (toletController.mypostPageloding.value) {
                          return const PostListSimmer(
                            topPadding: 20,
                            count: 3,
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
}

class MyPostsTolet extends StatefulWidget {
  final PostListTolet postData;
  final bool isLikedvalue;
  final int index;
  const MyPostsTolet({
    super.key,
    required this.postData,
    this.isLikedvalue = false,
    required this.index,
  });

  @override
  State<MyPostsTolet> createState() => _MyPostsToletState();
}

class _MyPostsToletState extends State<MyPostsTolet>
    with TickerProviderStateMixin {
  ToletController toletController = Get.find();
  UserController userController = Get.find();

  @override
  void initState() {
    // postController.singlepostTolet.clear();

    super.initState();
  }

  showPopUp() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete this post?'),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                PostListTolet removedItem =
                    toletController.mypostList.removeAt(widget.index);

                toletController.deleteKeyMypost.currentState!.removeItem(
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
                      child: MyPostsTolet(
                        postData: removedItem,
                        index: widget.index,
                      ),
                    ),
                  ),
                  duration: const Duration(
                    milliseconds: 600,
                  ),
                );
                toletController.deleteMypost(widget.postData.postId);
                Get.back();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
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
        // boxShadow: const [
        //   BoxShadow(color: Colors.black12, spreadRadius: 1.1),
        // ],
        border: Border.all(color: Colors.black.withOpacity(0.1)),
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
                      width: width / 2.85,
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
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    await showPopUp();
                  },
                  splashRadius: 30,
                  icon: const Icon(
                    Feather.trash_2,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    '${userController.getDay(widget.postData.time)}',
                    style: TextStyle(
                      color: const Color(0xff083437).withOpacity(0.3),
                      fontSize: 12,
                    ),
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
