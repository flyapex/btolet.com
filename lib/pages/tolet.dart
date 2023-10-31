import 'dart:convert';
import 'dart:ui';
import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/apimodel.dart';
import 'package:btolet/pages/toletpage.dart';
import 'package:btolet/widget/imageslidetolet.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'post/sorting/sortingtolet.dart';

class ToletHome extends StatefulWidget {
  const ToletHome({super.key});

  @override
  State<ToletHome> createState() => _ToletHomeState();
}

class _ToletHomeState extends State<ToletHome> {
  final scrollController = ScrollController();
  UserController userController = Get.find();
  PostController postController = Get.put(PostController());

  @override
  void initState() {
    postController.getAllPost();
    userController.getnote();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // print("You're at the top.");
        } else {
          postController.getAllPost();
        }
      }
    });
    super.initState();
  }

  @override
  void deactivate() {
    scrollController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: CustomRefreshIndicator(
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
            postController.allToletPost.clear();
            postController.allToletPost.refresh();
            postController.toletpage.value = 1;
            postController.getAllPost();
            postController.allToletPost.sentToStream;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Note(),
                const SizedBox(height: 20),
                const ImageSlideTolet(
                  topPadding: 10.0,
                  hight: 180,
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
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          const SortingTolet(),
                          elevation: 20.0,
                          enableDrag: true,
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          ignoreSafeArea: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          enterBottomSheetDuration:
                              const Duration(milliseconds: 170),
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.3)),
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
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: postController.allToletPost.stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      // Show a loading indicator
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        // key: UniqueKey(),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length + 1,
                        itemBuilder: (c, i) {
                          if (i < snapshot.data.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: PostsTolet(
                                postData: snapshot.data[i],
                              ),
                            );
                          } else {
                            if (postController.toletlodingPosts.value) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: SizedBox(
                                    width: 40.0,
                                    height: 40.0,
                                    child: CircularProgressIndicator(
                                      value: null,
                                      strokeWidth: 4,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostsTolet extends StatefulWidget {
  final ToletPostList postData;
  const PostsTolet({
    super.key,
    required this.postData,
  });

  @override
  State<PostsTolet> createState() => _PostsToletState();
}

class _PostsToletState extends State<PostsTolet> {
  PostController postController = Get.find();
  @override
  void initState() {
    // postController.singlepostTolet.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    // LocationController locationController = Get.put(LocationController());
    // String locationSeparatio(val) {
    //   List<String> words = val.split(', ');
    //   if (words.length >= 3) {
    //     String firstTwoWords = "${words[0]}, ${words[1]}";
    //     print("First two words: $firstTwoWords");
    //     return firstTwoWords;
    //   } else {
    //     print("Not enough words to extract.");
    //     return val;
    //   }
    // }
    return Container(
      height: height / 7,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, spreadRadius: 1.1),
        ],
      ),
      child: Stack(
        // alignment: Alignment.centerRight,
        children: [
          InkWell(
            onTap: () {
              print(widget.postData.postId);
              Get.to(
                () => ToletPage(postid: widget.postData.postId),
                transition: Transition.circularReveal,
                duration: const Duration(milliseconds: 600),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      image: MemoryImage(base64Decode(widget.postData.image1)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          // image: const DecorationImage(
                          //   image: NetworkImage(
                          //       'https://images.unsplash.com/photo-1501183638710-841dd1904471?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        child:
                            Image.memory(base64Decode(widget.postData.image1)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width - ((width / 2.8) + 40),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: SvgPicture.asset(
                                    'assets/icons/bed.svg',
                                    colorFilter: const ColorFilter.mode(
                                      // Color(0xff083437),
                                      Colors.black87,
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
                            Row(
                              children: [
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: SvgPicture.asset(
                                    'assets/icons/bath.svg',
                                    colorFilter: const ColorFilter.mode(
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
                            widget.postData.roomsize == ''
                                ? Row(
                                    children: [
                                      SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: SvgPicture.asset(
                                          'assets/icons/property/kitchen.svg',
                                          colorFilter: const ColorFilter.mode(
                                            // Color(0xff083437),
                                            Colors.black45,
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
                                          'assets/icons/size.svg',
                                          colorFilter: const ColorFilter.mode(
                                            // Color(0xff083437),
                                            Colors.black87,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "  ${NumberFormat.decimalPattern().format(int.parse(widget.postData.roomsize))} ft\u00b2",
                                        style: const TextStyle(
                                          color: Color(0xff083437),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                        // Text(
                        //   "Khulna Nirala",
                        //   style: TextStyle(
                        //     color: const Color(0xff083437).withOpacity(0.6),
                        //     fontSize: 12,
                        //   ),
                        // ),
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
                      color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                    );
                  },
                  animationDuration: const Duration(milliseconds: 400),
                ),
                const SizedBox(height: 20),
                Text(
                  ' ${timeago.format(widget.postData.time, locale: 'en_short')} ago',
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

class Note extends StatelessWidget {
  const Note({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    return Obx(
      () => Container(
        height: 30,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.black,
              letterSpacing: 0.5,
            ),
            child: Marquee(
              text: userController.note.value,
              // style: const TextStyle(
              //   fontWeight: FontWeight.bold,
              //   color: Colors.white,
              // ),
              scrollAxis: Axis.horizontal,
              // crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 100.0,
              velocity: 100.0,
              pauseAfterRound: const Duration(seconds: 1),
              // startPadding: 10.0,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
        ),
      ),
    );
  }
}
