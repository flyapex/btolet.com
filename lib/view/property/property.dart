import 'dart:convert';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/api.dart';
import 'package:btolet/view/home/shimmer/shimmer.dart';
import 'package:btolet/view/home/sorting/sortingproperty.dart';
import 'package:btolet/view/home/widget/imageslidetolet.dart';
import 'package:btolet/view/home/widget/post_btn.dart';
import 'package:btolet/view/post/property/propertypost.dart';
import 'package:btolet/view/tolet/tolet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'propertypage.dart';

class PropertyHome extends StatefulWidget {
  const PropertyHome({super.key});

  @override
  State<PropertyHome> createState() => _PropertyHomeState();
}

class _PropertyHomeState extends State<PropertyHome>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  LocationController locationController = Get.find();
  final scrollController = ScrollController();
  PostController postController = Get.find();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )
    ..addListener(() {
      // setState(() {});
    })
    ..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    end: Offset.zero,
    begin: const Offset(0, 3.4),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ),
  );

  @override
  void initState() {
    postController.getAllpropertyPost();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // print("You're at the top.");
        } else {
          postController.getAllpropertyPost();
        }
      }
      if (scrollController.position.pixels > 0) {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_offsetAnimation.isCompleted) {
            _controller.reverse();
          }
          // print("---------reverse--------");
        }
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          {
            _controller.forward();
            // print("---------forward--------");
          }
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double wt = Get.width;
    super.build(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: locationController.mapMode.value
          ? const SizedBox()
          : SlideTransition(
              position: _offsetAnimation,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: SizedBox(
                    height: wt / 9,
                    width: wt / 3.5,
                    child: UnicornOutlineButton(
                      onPressed: () {
                        Get.bottomSheet(
                          const PostNowProperty(),
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
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.cyanAccent, Colors.yellow],
                      ),
                      strokeWidth: 4,
                      radius: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 18,
                            width: 18,
                            child: SvgPicture.asset(
                              'assets/icons/plus.svg',
                              colorFilter: const ColorFilter.mode(
                                Color(0xff083437),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "Post",
                            style: TextStyle(
                              color: Color(0xff083437),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
      body: SingleChildScrollView(
        // physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Note(),
            const SizedBox(height: 20),
            const ImageSlideTolet(
              topPadding: 10.0,
              hight: 160, //180
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => RichText(
                    text: TextSpan(
                      text:
                          "${NumberFormat.decimalPattern().format(locationController.currentPostCountP.value)} ads in ",
                      style: TextStyle(
                          fontSize: 16, color: Colors.black.withOpacity(0.8)),
                      children: [
                        TextSpan(
                          text: locationController.locationAddressShort.value
                              .split(', ')[0],
                          // text: locationController
                          //             .locationAddressShort.value ==
                          //         "Location"
                          //     ? "Location"
                          //     : locationController
                          //         .locationAddressShort.value
                          //         .split(', ')[1],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      const SortingProperty(),
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
                      border: Border.all(color: Colors.black.withOpacity(0.3)),
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
            // const SizedBox(height: 20),
            Scrollbar(
              radius: const Radius.circular(20),
              child: StreamBuilder(
                stream: postController.allpropertyPost.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    // return const Center(
                    //   child: CircularProgressIndicator(
                    //     color: Colors.red,
                    //   ),
                    // );
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
                            child: PostsProperty(
                              postData: snapshot.data[i],
                            ),
                          );
                        } else {
                          if (postController.propertylodingPosts.value) {
                            // return const PostListSimmer(
                            //   topPadding: 20,
                            //   count: 4,
                            // );
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PostsProperty extends StatelessWidget {
  final PropertyList postData;
  final bool isLikedvalue;
  const PostsProperty({
    super.key,
    required this.postData,
    this.isLikedvalue = false,
  });

  @override
  Widget build(BuildContext context) {
    // var height = Get.height;
    // var width = Get.width;

    UserController userController = Get.find();

    // String currency(int amount, String symbol) {
    //   convertToBengaliDigits(val) {
    //     return userController.convertToBengaliDigits(val);
    //   }

    //   if (amount >= 10000000) {
    //     final crorePart = (amount / 10000000).floor();
    //     final lakhPart = (amount % 10000000) ~/ 100000;
    //     final thousandPart = (amount % 100000) ~/ 1000;

    //     String formattedAmount =
    //         '$symbol ${convertToBengaliDigits(crorePart)} কোটি';

    //     if (lakhPart > 0) {
    //       formattedAmount += ' ${convertToBengaliDigits(lakhPart)} লাখ';
    //     }

    //     if (thousandPart > 0) {
    //       formattedAmount += ' ${convertToBengaliDigits(thousandPart)} হাজার';
    //     }

    //     return formattedAmount;
    //   } else if (amount >= 100000) {
    //     final lakhPart = (amount / 100000).floor();
    //     final thousandPart = (amount % 100000) ~/ 1000;

    //     String formattedAmount =
    //         '$symbol ${convertToBengaliDigits(lakhPart)} লাখ';

    //     if (thousandPart > 0) {
    //       formattedAmount += ' ${convertToBengaliDigits(thousandPart)} হাজার';
    //     }

    //     return formattedAmount;
    //   } else {
    //     return '$symbol ${convertToBengaliDigits(amount)}';
    //   }
    // }

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
                    () => PropertyPage(pid: postData.pid),
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
                        userController.savedFavPostProperty(
                          postData.pid,
                          !isLiked,
                        );
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
                Text(
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
                            userController.convertToBengaliDigits(
                              int.parse(postData.measurementProperty),
                            ),
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
              border: Border.all(color: Colors.black.withOpacity(0.3)),
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
                      // ' ${timeago.format(widget.postData.time, locale: 'en_short')} ago',
                      //  "Listed 2 week ago",
                      Text(
                        // timeago.format(postData.time),
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
                                        'assets/icons/message.svg',
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
                                        'assets/icons/wapp.svg',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () async {
                              // MapsLauncher.launchCoordinates(
                              //   double.parse(postData.geolat),
                              //   double.parse(postData.geolon),
                              // );
                              // final availableMaps =
                              //     await MapLauncher.installedMaps;
                              // print(availableMaps);

                              // await availableMaps.first.showMarker(
                              //   coords: Coords(
                              //     double.parse(postData.geolat),
                              //     double.parse(postData.geolon),
                              //   ),
                              //   title: postData.price.toString(),
                              // );
                              final coords = Coords(
                                double.parse(postData.geolat),
                                double.parse(postData.geolon),
                              );
                              var title =
                                  "Price ৳ ${NumberFormat.decimalPattern().format(postData.price)}";
                              final availableMaps =
                                  await MapLauncher.installedMaps;
                              print(availableMaps.length);
                              if (availableMaps.length == 1) {
                                await availableMaps.first.showMarker(
                                  coords: coords,
                                  title: title,
                                  description: "description",
                                );
                              } else {
                                Get.bottomSheet(
                                  SafeArea(
                                    child: SingleChildScrollView(
                                      child: Wrap(
                                        children: <Widget>[
                                          for (var map in availableMaps)
                                            ListTile(
                                              onTap: () => map.showMarker(
                                                coords: coords,
                                                title: title,
                                              ),
                                              title: Text(map.mapName),
                                              leading: SvgPicture.asset(
                                                map.icon,
                                                height: 30.0,
                                                width: 30.0,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
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
