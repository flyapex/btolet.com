import 'dart:convert';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/pro_model.dart';
import 'package:btolet/view/home/widget/imageslider.dart';
import 'package:btolet/view/home/widget/note.dart';
import 'package:btolet/view/property/single_post.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:btolet/view/sort/pro/sorting_pro.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class Property extends StatefulWidget {
  const Property({super.key});

  @override
  State<Property> createState() => _PropertyState();
}

class _PropertyState extends State<Property> {
  ProController proController = Get.put(ProController());
  LocationController locationController = Get.find();
  bool _atEnd = false;
  @override
  void initState() {
    proController.getAllPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener(
      onNotification: (scrollNotification) {
        if (_atEnd &&
            scrollNotification is ScrollUpdateNotification &&
            scrollNotification.metrics.atEdge &&
            scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
          setState(() {
            _atEnd = false;
          });
        } else if (!_atEnd &&
            scrollNotification is ScrollEndNotification &&
            scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
          setState(() {
            _atEnd = true;
          });
          // Perform any action when scroll reaches the end
          proController.getAllPost();
          print('Reached the end of the list!');
        }
        return false;
      },
      child: Scrollbar(
        child: CustomRefreshIndicator(
          key: proController.refreshkey,
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
            locationController.getCurrnetlanlongLocation();
            // postController.allPropertyPost.clear();
            // postController.allPropertyPost.refresh();
            // postController.Propertypage.value = 1;
            // postController.getAllPost();
            // postController.allPropertyPost.sentToStream;
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Note(),
                const SizedBox(height: 20),
                const ImageSlide(
                  topPadding: 10.0,
                  height: 160, //180
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => proController.currentPostCountLoding.value
                          ? const ShimmerSortPostCount()
                          : RichText(
                              text: TextSpan(
                                text:
                                    "${NumberFormat.decimalPattern().format(proController.currentPostCount.value)} ads in ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.8)),
                                children: [
                                  TextSpan(
                                    text: locationController
                                        .locationAddressShort.value
                                        .split(', ')[0],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          const SortingPro(),
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
                  stream: proController.allPost.stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const PostListSimmer(
                        topPadding: 20,
                        count: 10,
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
                              child: PostsPro(
                                postData: snapshot.data[i],
                              ),
                            );
                          } else {
                            if (proController.lodingPosts.value) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
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
    ));
  }
}

class PostsPro extends StatelessWidget {
  final PostListPro postData;
  final bool isLikedvalue;
  const PostsPro({
    super.key,
    required this.postData,
    this.isLikedvalue = false,
  });

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();

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
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => SinglePost(pid: postData.pid),
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
                      image: MemoryImage(base64Decode(postData.image1)),
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
                    LikeButton(
                      size: 30,
                      isLiked: isLikedvalue,
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
                      onTap: (isLiked) async {
                        print(!isLiked);
                        // userController.savedFavPostProperty(
                        //   postData.pid,
                        //   !isLiked,
                        // );
                        return !isLiked;
                      },
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
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //৳
                postData.price == 0
                    ? const Text(
                        'Call For Price',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      )
                    : Text(
                        "${NumberFormat.decimalPattern().format(postData.price)} BDT",
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xff083437),
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                Row(
                  children: [
                    const Icon(
                      Feather.map_pin,
                      size: 16,
                      color: Colors.black45,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      postData.location,
                      style: const TextStyle(
                        color: Color(0xff083437),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(height: postData.bed == "" ? 10 : 4),
                postData.bed == ""
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            postData.measurement,
                            style: const TextStyle(
                              color: Color(0xff083437),
                              fontSize: 18,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            postData.area,
                            style: const TextStyle(
                              color: Color(0xff083437),
                              fontSize: 19,
                              height: 1.2,
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
                            postData.bed,
                            style: const TextStyle(
                              color: Color(0xff083437),
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
                            postData.bath,
                            style: const TextStyle(
                              color: Color(0xff083437),
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
                            postData.size,
                            style: const TextStyle(
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
                          backgroundImage: NetworkImage(postData.image),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${userController.getDayfull(postData.time)}',
                        style: const TextStyle(
                          color: Color(0xff68676C),
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
                              final call = Uri.parse('tel:${postData.phone}');
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
                              final sms = Uri.parse('sms:${postData.phone}');
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
