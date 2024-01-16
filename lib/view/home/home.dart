import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/map/map_tolet.dart';
import 'package:btolet/view/map/widget/map_button_top.dart';
import 'package:btolet/view/post/property.dart';
import 'package:btolet/view/post/tolet.dart';
import 'package:btolet/view/tolet/tolet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import '../map/location_sheet.dart';
import '../map/map_property.dart';
import '../property/property.dart';
import 'drawer/drawer.dart';
import 'widget/post_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late ScrollController scrollController;
  UserController userController = Get.put(UserController());
  LocationController locationController = Get.put(LocationController());
  var index = 0;
  @override
  void initState() {
    userController.tabController = TabController(vsync: this, length: 2);
    userController.tabController.addListener(_handleTabSelection);
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    userController.getnote();
    super.initState();
  }

  void _handleTabSelection() {
    locationController.resetAnimation(false);
    setState(() {
      print(userController.tabController.index);
      index = userController.tabController.index;
    });
  }

  _scrollListener() {
    // if (scrollController.offset >=
    //         scrollController.position.maxScrollExtent &&
    //     !scrollController.position.outOfRange) {
    //   setState(() {
    //     debugPrint("reach the top");
    //   });
    // }
    // if (scrollController.offset <=
    //         scrollController.position.minScrollExtent &&
    //     !scrollController.position.outOfRange) {
    //   setState(() {
    //     debugPrint("reach the bottom");
    //   });
    // }
    if (scrollController.position.pixels > 0) {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_offsetAnimation.isCompleted) {
          _controller.reverse();
        }
        print("---------reverse--------");
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        {
          _controller.forward();
          print("---------forward--------");
        }
      }
    }
  }

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
  Widget build(BuildContext context) {
    super.build(context);
    double wt = Get.width;
    return Obx(
      () => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: locationController.mapModetolet.value ||
                locationController.mapModePro.value
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
                      child: PostButton(
                        onPressed: () {
                          userController.tabController.index == 0
                              ? Get.bottomSheet(
                                  const PostTolet(),
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
                                )
                              : Get.bottomSheet(
                                  const PostPro(),
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
                          colors: [
                            Colors.blue,
                            Colors.cyanAccent,
                            Colors.yellow
                          ],
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
                                'assets/icons/home/plus.svg',
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
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue,
          ),
          child: const CustomeDrawer(),
        ),
        body: SafeArea(
          child: NestedScrollView(
            controller: scrollController,
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  floating: true,
                  title: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: CircleAvatar(
                          backgroundImage: NetworkImage(
                            userController.image.value,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      SizedBox(
                        width: Get.width / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  () => const LocationSheet(),
                                  duration: const Duration(milliseconds: 170),
                                  transition: Transition.circularReveal,
                                  fullscreenDialog: true,
                                );
                              },
                              splashColor: Colors.black12,
                              child: Row(
                                children: [
                                  Obx(
                                    () => Text(
                                      locationController
                                          .locationAddressShort.value
                                          .split(',')[0],
                                      style: TextStyle(
                                        color: const Color(0xff1A3259)
                                            .withOpacity(0.8),
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dotted,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  const Icon(
                                    Icons.place_outlined,
                                    color: Colors.blueAccent,
                                    size: 13,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Material(
                          color: const Color(0xffF0F0F0),
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.search,
                                color: Colors.black.withOpacity(0.2),
                                size: 28,
                              ),
                            ),
                            onTap: () async {
                              Get.to(
                                () => const LocationSheet(),
                                duration: const Duration(milliseconds: 170),
                                transition: Transition.circularReveal,
                                fullscreenDialog: true,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: MapButton(
                        width: 96,
                        height: 40,
                        fontSize: 17,
                        textOn: 'LIST',
                        textOff: 'MAP',
                        colorOn: Colors.blue,
                        colorOff: Colors.blue,
                        iconOn: Feather.map_pin,
                        iconOff: Feather.align_left,
                        textSize: 16.0,
                        animationDuration: Duration(milliseconds: 250),
                      ),
                    ),
                  ],
                  elevation: 0.0,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomTab(40.0),
                ),
              ];
            },
            body: TabBarView(
              controller: userController.tabController,
              children: [
                locationController.mapModetolet.value
                    ? const MapTolet()
                    : const Tolet(),
                locationController.mapModePro.value
                    ? const MapProperty()
                    : const Property()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CustomTab extends SliverPersistentHeaderDelegate {
  final double size;

  CustomTab(this.size);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    UserController userController = Get.find();
    return Container(
      color: Colors.white,
      height: size,
      child: TabBar(
        controller: userController.tabController,
        onTap: (v) {
          // print(v);
        },
        tabs: <Widget>[
          Tab(
            child: SizedBox(
              width: Get.width / 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                      'assets/icons/home/tolet.svg',
                      colorFilter: const ColorFilter.mode(
                        // Color(0xff083437),
                        Colors.black87,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Rent',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Tab(
            child: SizedBox(
              width: Get.width / 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      'assets/icons/home/property.svg',
                      colorFilter: const ColorFilter.mode(
                        // Color(0xff083437),
                        Colors.black87,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Buy',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(CustomTab oldDelegate) {
    return oldDelegate.size != size;
  }
}
