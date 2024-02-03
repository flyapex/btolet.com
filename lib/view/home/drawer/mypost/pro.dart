import 'dart:convert';
import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/pro_model.dart';
import 'package:btolet/view/property/single_post.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProPage extends StatefulWidget {
  const MyProPage({super.key});

  @override
  State<MyProPage> createState() => _MyProPageState();
}

class _MyProPageState extends State<MyProPage>
    with AutomaticKeepAliveClientMixin {
  ProController proController = Get.find();

  final scrollController = ScrollController();

  @override
  void initState() {
    proController.myPost();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("You're at the top.");
        } else {
          print("You're at the Bottom.");

          proController.myPost();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    proController.mypostPage.value = 1;
    proController.mypostList.clear();
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
          proController.mypostList.clear();
          proController.mypostList.refresh();
          proController.mypostPage.value = 1;
          proController.myPost();
          proController.mypostList.sentToStream;
        },
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: StreamBuilder(
              stream: proController.mypostList.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const PostListSimmer(
                    topPadding: 20,
                    count: 10,
                  );
                } else {
                  return AnimatedList(
                    key: proController.deleteKeyMypost,
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    initialItemCount: proController.mypostList.length,
                    padding: const EdgeInsets.only(bottom: 100),
                    itemBuilder: (context, i, animation) {
                      if (i < snapshot.data.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: MyPostsPro(
                            postData: snapshot.data[i],
                            index: i,
                          ),
                        );
                      } else {
                        if (proController.mypostPageloding.value) {
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

class MyPostsPro extends StatefulWidget {
  final PostListPro postData;
  final bool isLikedvalue;
  final int index;
  const MyPostsPro({
    super.key,
    required this.postData,
    this.isLikedvalue = false,
    required this.index,
  });

  @override
  State<MyPostsPro> createState() => _MyPostsProState();
}

class _MyPostsProState extends State<MyPostsPro> {
  ProController proController = Get.find();
  showPopUp() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Delete this post?',
            style: h3,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                PostListPro removedItem =
                    proController.mypostList.removeAt(widget.index);

                proController.deleteKeyMypost.currentState!.removeItem(
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
                      child: MyPostsPro(
                        postData: removedItem,
                        index: widget.index,
                      ),
                    ),
                  ),
                  duration: const Duration(
                    milliseconds: 600,
                  ),
                );
                proController.deleteMypost(widget.postData.pid);
                Get.back();
              },
              child: Text(
                'Yes',
                style: h3,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'No',
                style: h3,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();

    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withOpacity(0.1))
          // boxShadow: const [
          //   BoxShadow(color: Colors.black12, spreadRadius: 1.1),
          // ],
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => SinglePostPro(pid: widget.postData.pid),
                        transition: Transition.circularReveal,
                        duration: const Duration(milliseconds: 600),
                      );
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image:
                              MemoryImage(base64Decode(widget.postData.image1)),
                          fit: BoxFit.cover,
                          // alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Material(
                            color: Colors.black26,
                            child: InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Feather.trash_2,
                                  color: Colors.white,
                                  size: 21,
                                ),
                              ),
                              onTap: () async {
                                await showPopUp();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                  bottom: 6,
                ),
                child: SizedBox(
                  width: 44,
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
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.postData.category} ",
                  style: const TextStyle(
                    color: Color(0xff083437),
                    fontSize: s2,
                    height: 0.8,
                  ),
                ),
                const SizedBox(height: 12),
                widget.postData.price == 0
                    ? Text(
                        'Price On Call',
                        style: TextStyle(
                          fontSize: s1,
                          height: 0.8,
                          color: const Color(0xff083437).withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        "${userController.currency(widget.postData.price)}  BDT",
                        style: TextStyle(
                          fontSize: s1,
                          height: 0.8,
                          color: const Color(0xff083437).withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Feather.map_pin,
                      size: 16,
                      color: Colors.black45,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.postData.location,
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xff083437).withOpacity(0.6),
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 10),
                // SizedBox(height: postData.bed == "" ? 10 : 4),
                const SizedBox(height: 8),
                widget.postData.bed == ""
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.postData.measurement,
                            style: TextStyle(
                              color: const Color(0xff083437).withOpacity(0.7),
                              fontSize: 16,
                              height: 1.2,
                              fontFamily: 'Roboto',
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.postData.area,
                            style: TextStyle(
                              color: const Color(0xff083437).withOpacity(0.8),
                              fontSize: 17,
                              height: 1.2,
                              fontFamily: 'Roboto',
                            ),
                          )
                        ],
                      )
                    : Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: SizedBox(
                              height: 24,
                              width: 24,
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
                              color: Color(0xff083437),
                              fontSize: s4,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 24,
                            width: 24,
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
                              color: Color(0xff083437),
                              fontSize: s4,
                            ),
                          ),
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
                          Text(
                            '${widget.postData.size}  ft\u00b2',
                            style: const TextStyle(
                              color: Color(0xff083437),
                              fontSize: s4,
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
              border: Border(
                top: BorderSide(
                  width: 0.9,
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: CircleAvatar(
                          backgroundImage: NetworkImage(widget.postData.image),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${userController.getDayfull(widget.postData.time)}',
                        style: const TextStyle(
                          color: Color(0xff68676C),
                          fontSize: s4,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          color: const Color(0xffF36251),
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
                              final call =
                                  Uri.parse('tel:${widget.postData.phone}');
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
                          color: const Color(0xff27D468),
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SizedBox(
                                height: 26,
                                width: 26,
                                child: Center(
                                  child: SizedBox(
                                    height: 23,
                                    width: 23,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icons/property/message.svg',
                                        // ignore: deprecated_member_use
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () async {
                              final sms =
                                  Uri.parse('sms:${widget.postData.phone}');
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
                          color: const Color(0xff27D468),
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SizedBox(
                                height: 26,
                                width: 26,
                                child: Center(
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icons/home/wapp.svg',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () async {
                              // final coords = Coords(
                              //   double.parse(postData.geolat),
                              //   double.parse(postData.geolon),
                              // );
                              // var title =
                              //     "Price ৳ ${NumberFormat.decimalPattern().format(postData.price)}";
                              // final availableMaps =
                              //     await MapLauncher.installedMaps;
                              // print(availableMaps.length);
                              // if (availableMaps.length == 1) {
                              //   await availableMaps.first.showMarker(
                              //     coords: coords,
                              //     title: title,
                              //     description: "description",
                              //   );
                              // } else {
                              //   Get.bottomSheet(
                              //     SafeArea(
                              //       child: SingleChildScrollView(
                              //         child: Wrap(
                              //           children: <Widget>[
                              //             for (var map in availableMaps)
                              //               ListTile(
                              //                 onTap: () => map.showMarker(
                              //                   coords: coords,
                              //                   title: title,
                              //                 ),
                              //                 title: Text(map.mapName),
                              //                 leading: SvgPicture.asset(
                              //                   map.icon,
                              //                   height: 30.0,
                              //                   width: 30.0,
                              //                 ),
                              //               ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   );
                              // }
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
