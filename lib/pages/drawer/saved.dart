import 'dart:convert';

import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/features/buypagetemp.dart';
import 'package:btolet/model/apimodel.dart';
import 'package:btolet/pages/property.dart';
import 'package:btolet/pages/toletpage.dart';
import 'package:btolet/widget/shimmer/shimmer.dart';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  UserController userController = Get.find();
  @override
  void initState() {
    userController.tabControllerDrawer = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Post'),
        centerTitle: false,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Feather.chevron_left),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0),
              insets: EdgeInsets.symmetric(horizontal: 30),
            ),
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.black,
            tabs: const [
              Tab(
                text: 'Rent',
                // icon: Icon(Icons.account_circle_outlined),
              ),
              Tab(
                text: 'Buy',
                // icon: Icon(Icons.account_circle_outlined),
              ),
            ],
            controller: userController.tabControllerDrawer,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              controller: userController.tabControllerDrawer,
              children: const [
                SavedToletPage(),
                PropertyHomeTEMP()
                // SavedProperty(),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SavedToletPage extends StatefulWidget {
  const SavedToletPage({super.key});

  @override
  State<SavedToletPage> createState() => _SavedToletPageState();
}

class _SavedToletPageState extends State<SavedToletPage> {
  UserController userController = Get.find();
  final scrollController = ScrollController();

  @override
  void initState() {
    userController.getAllsavedPostTolet();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("You're at the top.");
        } else {
          print("You're at the Bottom.");

          userController.getAllsavedPostTolet();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    userController.savedPostToletPage.value = 1;
    userController.allToletSavedPost.clear();
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
          userController.allToletSavedPost.clear();
          userController.allToletSavedPost.refresh();
          userController.savedPostToletPage.value = 1;
          userController.getAllsavedPostTolet();
          userController.allToletSavedPost.sentToStream;
        },
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: StreamBuilder(
              stream: userController.allToletSavedPost.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const PostListSimmer(
                    topPadding: 20,
                    count: 10,
                  );
                } else {
                  return AnimatedList(
                    key: userController.deleteKeySaved,
                    controller: scrollController,
                    initialItemCount: userController.allToletSavedPost.length,
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
                        if (userController.savedPostToletloding.value) {
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

class SavedProperty extends StatelessWidget {
  const SavedProperty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      radius: const Radius.circular(20),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            // const SizedBox(height: 20),
            // const Align(
            //   alignment: Alignment.centerRight,
            //   child: Text(
            //     'Sort by',
            //     style: TextStyle(
            //       fontSize: 14,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
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

//*--------------------------------element

class PostsToletSaved extends StatefulWidget {
  final MyPostListTolet postData;
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
  PostController postController = Get.find();
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
                  // child: ClipRRect(
                  //   borderRadius: const BorderRadius.only(
                  //     topLeft: Radius.circular(10),
                  //     bottomLeft: Radius.circular(10),
                  //   ),
                  //   child: BackdropFilter(
                  //     filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  //     child: Container(
                  //       alignment: Alignment.center,
                  //       decoration: BoxDecoration(
                  //         color: Colors.grey.withOpacity(0.1),
                  //       ),
                  //       child:
                  //           Image.memory(base64Decode(widget.postData.image1)),
                  //     ),
                  //   ),
                  // ),
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
                                            'assets/icons/bed.svg',
                                            colorFilter: const ColorFilter.mode(
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
                                                  'assets/icons/kitchen2.svg',
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
                                                  'assets/icons/size.svg',
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: SvgPicture.asset(
                                          'assets/icons/carparking.svg',
                                          colorFilter: const ColorFilter.mode(
                                            // Color(0xff083437),
                                            Colors.black87,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: SvgPicture.asset(
                                          'assets/icons/bikeparking.svg',
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
                    MyPostListTolet removedItem =
                        userController.allToletSavedPost.removeAt(widget.index);

                    userController.deleteKeySaved.currentState!.removeItem(
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
                    userController.savedFavPostTolet(
                      widget.postData.postId,
                      !isLiked,
                    );
                    return !isLiked;
                  },
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
