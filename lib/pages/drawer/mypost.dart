import 'dart:convert';
import 'dart:ui';
import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/apimodel.dart';
import 'package:btolet/pages/toletpage.dart';
import 'package:btolet/widget/shimmer/shimmer.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyPost extends StatefulWidget {
  const MyPost({super.key});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost>
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
        title: const Text('My Post'),
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
                text: 'RENT',
                // icon: Icon(Icons.account_circle_outlined),
              ),
              Tab(
                text: 'SELL',
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
                MyToletPage(),
                MyTPropertyPage(),
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

class MyToletPage extends StatefulWidget {
  const MyToletPage({super.key});

  @override
  State<MyToletPage> createState() => _MyToletPageState();
}

class _MyToletPageState extends State<MyToletPage> {
  UserController userController = Get.find();
  final scrollController = ScrollController();

  @override
  void initState() {
    userController.getmypostPageTolet();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("You're at the top.");
        } else {
          print("You're at the Bottom.");

          userController.getmypostPageTolet();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    userController.mypostPageTolet.value = 1;
    userController.mypostListTolet.clear();

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
          userController.mypostListTolet.clear();
          userController.mypostListTolet.refresh();
          userController.mypostPageTolet.value = 1;
          userController.getmypostPageTolet();
          userController.mypostListTolet.sentToStream;
        },
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: StreamBuilder(
              stream: userController.mypostListTolet.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const PostListSimmer(
                    topPadding: 20,
                    count: 10,
                  );
                } else {
                  return AnimatedList(
                    key: userController.deleteKeyMypost,
                    controller: scrollController,
                    initialItemCount: userController.mypostListTolet.length,
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
                        if (userController.mypostPagelodingTolet.value) {
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

class MyTPropertyPage extends StatelessWidget {
  const MyTPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(
        'Page Here',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}

class MyPostsTolet extends StatefulWidget {
  final ToletPostList postData;
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
  PostController postController = Get.find();
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
                ToletPostList removedItem =
                    userController.mypostListTolet.removeAt(widget.index);

                userController.deleteKeyMypost.currentState!.removeItem(
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
                userController.deleteMypostTolet(widget.postData.postId);
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
                    ' ${timeago.format(widget.postData.time, locale: 'en_short')} ago',
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
