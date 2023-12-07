import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/widget/post_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'controller/db_controller.dart';
import 'controller/location_controller.dart';
import 'controller/user_controller.dart';
import 'pages/map/map_button_top.dart';
import 'pages/map/multi_map.dart';
import 'pages/post/property/propertypost.dart';
import 'pages/property.dart';
import 'pages/sorting/sortingproperty.dart';
import 'pages/sorting/sortingtolet.dart';
import 'pages/post/tolet/posttolet.dart';
import 'pages/tolet.dart';
import 'pages/map/location_sheet_map.dart';
import 'widget/drawer.dart';
import 'package:lottie/lottie.dart';

class MapLodingPage extends StatelessWidget {
  const MapLodingPage({super.key});

  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.put(LocationController());
    UserController userController = Get.put(UserController());
    final DBController dbController = Get.put(DBController());

    getUserDetails() async {
      await userController.userDetailsByID(await dbController.getUserID());
    }

    getUserDetails();

    return Obx(
      () => locationController.isLoading.value
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                alignment: Alignment.center,
                children: [
                  const LocationSheet(),
                  Container(
                    color: Colors.white,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     SizedBox(
                        //       height: 40,
                        //       width: 40,
                        //       child: SvgPicture.asset(
                        //         'assets/logo/logo.svg',
                        //         colorFilter: const ColorFilter.mode(
                        //           Color(0xff096EFE),
                        //           // Colors.black87,
                        //           // Colors.black87,
                        //           BlendMode.srcIn,
                        //         ),
                        //       ),
                        //     ),
                        //     AnimatedTextKit(
                        //       pause: const Duration(milliseconds: 1400),
                        //       repeatForever: true,
                        //       animatedTexts: [
                        //         TypewriterAnimatedText(
                        //           'Btolet',
                        //           speed: const Duration(milliseconds: 150),
                        //           textStyle: const TextStyle(
                        //             fontSize: 32.0,
                        //             fontWeight: FontWeight.bold,
                        //             color: Colors.black,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
// Icon(icon)

                        userController.name.value.isEmpty
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'welcome ',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black45,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: userController.name.value
                                              .toLowerCase(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Lottie.asset(
                                        'assets/lottie/smile.json',
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                        const SizedBox(),
                        // Lottie.asset('assets/lottie/location.json'),
                        // Lottie.asset('assets/lottie/globe.json'),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            child: Lottie.asset(
                              'assets/lottie/location.json',
                            ),
                          ),
                        ),

                        const SizedBox(),
                        const SizedBox(),

                        const Column(
                          children: [
                            // userController.name.value.isEmpty
                            // ? const SizedBox()
                            // : AnimatedTextKit(
                            //     pause: const Duration(milliseconds: 1400),
                            //     repeatForever: true,
                            //     animatedTexts: [
                            //       FadeAnimatedText(
                            //         'welcome ${userController.name.value.toLowerCase()}',
                            //         // speed:
                            //         //     const Duration(milliseconds: 150),
                            //         textStyle: const TextStyle(
                            //           fontSize: 20.0,
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.black45,
                            //         ),
                            //       ),
                            //       FadeAnimatedText(
                            //         'welcome ${userController.name.value.toLowerCase()}',
                            //         // speed:
                            //         //     const Duration(milliseconds: 150),
                            //         textStyle: const TextStyle(
                            //           fontSize: 20.0,
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.black45,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Color(0xffa1adb7),
                                ),
                                SizedBox(width: 3),
                                // AnimatedTextKit(
                                //   pause: const Duration(milliseconds: 1400),
                                //   repeatForever: true,
                                //   animatedTexts: [
                                //     TypewriterAnimatedText(
                                //       'Locating you',
                                //       speed: const Duration(milliseconds: 130),
                                //       textStyle: const TextStyle(
                                //         fontSize: 14,
                                //         color: Color(0xffa1adb7),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Text(
                                  'Locating you',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffa1adb7),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  LocationController locationController = Get.put(LocationController());
  PostController postController = Get.put(PostController());
  final GlobalKey<NestedScrollViewState> globalKey = GlobalKey();
  // late TabController _tabController = postController.tabController;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )
    ..addListener(() {
      setState(() {});
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
  double wt = Get.width;

  final scrollController = ScrollController();
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    userController.getnote();
    locationController.getCurrnetlanlongLocation();

    // scrollController.addListener(() {
    //   if (scrollController.position.pixels > 0) {
    //     if (scrollController.position.userScrollDirection ==
    //         ScrollDirection.reverse) {
    //       if (_offsetAnimation.isCompleted) _controller.reverse();
    //       // print("---------reverse--------");
    //     }
    //     if (scrollController.position.userScrollDirection ==
    //         ScrollDirection.forward) {
    //       // print("---------forward--------");
    //       _controller.forward();
    //     }
    //   }

    //   if (scrollController.position.atEdge) {
    //     if (scrollController.position.pixels == 0) {
    //       print("You're at the top.");
    //     } else {
    //       print("You're at the bottom.");
    //     }
    //   }
    // });
    postController.tabController = TabController(vsync: this, length: 2);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      globalKey.currentState!.innerController.addListener(() {
        // print('notify');
        if (globalKey.currentState!.innerController.position.pixels > 0) {
          if (globalKey
                  .currentState!.innerController.position.userScrollDirection ==
              ScrollDirection.reverse) {
            if (_offsetAnimation.isCompleted) _controller.reverse();
            // print("---------reverse--------");
          }
          if (globalKey
                  .currentState!.innerController.position.userScrollDirection ==
              ScrollDirection.forward) {
            // print("---------forward--------");
            _controller.forward();
          }
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(
      () => Scaffold(
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
                          postController.tabController.index.isEven
                              ? Get.bottomSheet(
                                  const PostNowTolet(),
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
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue,
          ),
          child: const CustomeDrawer(),
        ),
        body: SafeArea(
          child: NestedScrollView(
            // controller: scrollController,
            floatHeaderSlivers: true,
            key: globalKey,
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
                      ClipRRect(
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
                    ],
                  ),
                  // flexibleSpace: FlexibleSpaceBar(
                  //   background: Center(
                  //     child: Text(
                  //       'Btolet',
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //         color: Colors.blue.withOpacity(0.5),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                            onTap: () {
                              postController.tabController.index.isEven
                                  ? Get.bottomSheet(
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
                                    )
                                  : Get.bottomSheet(
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
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: MapButton(
                        width: 96,
                        height: 40,
                        fontSize: 17,
                        onTap: () {},
                        onDoubleTap: () {},
                        onSwipe: () {},
                        value: locationController.mapMode.value,
                        textOn: 'LIST',
                        textOff: 'MAP',
                        colorOn: Colors.blue,
                        colorOff: Colors.blue,
                        iconOn: Feather.map_pin,
                        iconOff: Feather.align_left,
                        textSize: 16.0,
                        onChanged: (bool state) {
                          print(state);
                          locationController.mapMode.value =
                              !locationController.mapMode.value;
                        },
                        animationDuration: const Duration(milliseconds: 250),
                      ),
                    ),
                  ],
                  elevation: 0.0,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomTab(40.0, postController.tabController),
                ),
              ];
            },
            body: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverFillRemaining(
                  child: TabBarView(
                    // physics: const NeverScrollableScrollPhysics(),
                    controller: postController.tabController,
                    children: [
                      locationController.mapMode.value
                          ? const MultiMap()
                          : const ToletHome(),
                      const PropertyHome(),
                      // const PropertyHomeTEMP(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTab extends SliverPersistentHeaderDelegate {
  final double size;
  // ignore: prefer_typing_uninitialized_variables
  final _tabController;
  CustomTab(this.size, this._tabController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      height: size,
      child: TabBar(
        controller: _tabController,
        onTap: (v) {
          print(v);
        },
        // indicatorWeight: 3,
        // indicatorColor: Colors.white,
        // labelColor: Colors.white,
        // unselectedLabelColor: Colors.white60,
        // isScrollable: true,
        tabs: <Widget>[
          // Tab(icon: Icon(Feather.radio)),
          // const Tab(icon: Icon(Icons.business_outlined)),
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
                      'assets/icons/tolet.svg',
                      colorFilter: const ColorFilter.mode(
                        // Color(0xff083437),
                        Colors.black54,
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
                      'assets/icons/building.svg',
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
