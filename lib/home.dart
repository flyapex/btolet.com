import 'package:btolet/widget/post_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'controller/location_controller.dart';
import 'pages/map/multi_map.dart';
import 'pages/property.dart';
import 'pages/tolet.dart';
import 'pages/map/location_sheet_map.dart';
import 'pages/map/map_button_top.dart';
import 'widget/drawer.dart';
import 'widget/tolet/posttolet.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  LocationController locationController = Get.put(LocationController());

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
  @override
  void initState() {
    locationController.getCurrnetlanlongLocation();
    scrollController.addListener(() {
      if (scrollController.position.pixels > 0) {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_offsetAnimation.isCompleted) _controller.reverse();
          print("---------reverse--------");
        }
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          print("---------forward--------");
          _controller.forward();
        }
      }

      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("You're at the top.");
        } else {
          print("You're at the bottom.");
        }
      }
    });
    super.initState();
  }

  @override
  void deactivate() {
    scrollController.dispose();
    _controller.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
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
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: SizedBox(
                      height: wt / 9,
                      width: wt / 3.5,
                      child: UnicornOutlineButton(
                        onPressed: () {
                          Get.bottomSheet(
                            const PostNow(),
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
                            const Icon(Icons.add),
                            const SizedBox(width: 6),
                            Text(
                              'Sell',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.70),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: [
        //       const DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //         ),
        //         child: Text('Drawer Header'),
        //       ),
        //       ListTile(
        //         leading: const Icon(
        //           Icons.home,
        //         ),
        //         title: const Text('Page 1'),
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //       ListTile(
        //         leading: const Icon(
        //           Icons.train,
        //         ),
        //         title: const Text('Page 2'),
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ],
        //   ),
        // ),

        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue,
          ),
          child: const CustomeDrawer(),
        ),
        body: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: NestedScrollView(
              controller: scrollController,
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, value) {
                return [
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
                          icon: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://lh3.googleusercontent.com/a/AAcHTtdx1wQM-1NXgarrI1Ya4-6q0OtKawcqY55DHK3YBw"),
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
                                  Text(
                                    'Khulna',
                                    style: TextStyle(
                                      color: const Color(0xff1A3259)
                                          .withOpacity(0.8),
                                      decoration: TextDecoration.underline,
                                      decorationStyle:
                                          TextDecorationStyle.dotted,
                                      fontSize: 14,
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
                              onTap: () {},
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: MapButton(
                          width: 90,
                          height: 40,
                          onTap: () {},
                          onDoubleTap: () {},
                          onSwipe: () {},
                          value: locationController.mapMode.value,
                          iconOn: Feather.map_pin,
                          iconOff: Feather.align_left,
                          textOn: Feather.align_left,
                          textOff: Feather.map_pin,
                          colorOn: Colors.blue,
                          colorOff: Colors.blue,
                          onChanged: (bool state) {
                            locationController.mapMode.value =
                                !locationController.mapMode.value;
                          },
                          animationDuration: const Duration(milliseconds: 250),
                        ),
                      ),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(50),
                      //   child: Material(
                      //     child: InkWell(
                      //       child: const Padding(
                      //         padding: EdgeInsets.all(5),
                      //         child: Icon(Icons.search, size: 28),
                      //       ),
                      //       onTap: () {},
                      //     ),

                      //   ),
                      // ),
                      // RotatedBox(
                      //   quarterTurns: 1,
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(50),
                      //     child: Material(
                      //       child: InkWell(
                      //         child: const Padding(
                      //           padding: EdgeInsets.all(5),
                      //           child: Icon(FontAwesome.sliders, size: 26),
                      //         ),
                      //         onTap: () {},
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 20),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(50),
                      //     child: Material(
                      //       child: InkWell(
                      //         child: const Padding(
                      //           padding: EdgeInsets.all(5),
                      //           child: Icon(Feather.message_square, size: 26),
                      //         ),
                      //         onTap: () {},
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  locationController.mapMode.value
                      ? const MultiMap()
                      : NotificationListener<ScrollEndNotification>(
                          onNotification: (scrollEnd) {
                            final metrics = scrollEnd.metrics;
                            if (metrics.atEdge) {
                              bool isTop = metrics.pixels == 0;
                              if (isTop) {
                                print('At the top');
                              } else {
                                print('At the bottom');
                              }
                            }
                            return true;
                          },
                          child: const ToletHome(),
                        ),
                  NotificationListener<ScrollEndNotification>(
                    onNotification: (scrollEnd) {
                      final metrics = scrollEnd.metrics;
                      if (metrics.atEdge) {
                        bool isTop = metrics.pixels == 0;
                        if (isTop) {
                          print('At the top');
                        } else {
                          print('At the bottom');
                        }
                      }
                      return true;
                    },
                    child: const PropertyHome(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTab extends SliverPersistentHeaderDelegate {
  final double size;
  CustomTab(this.size);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      height: size,
      child: TabBar(
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
              height: 30,
              width: 30,
              child: SvgPicture.asset(
                'assets/icons/tolet.svg',
                colorFilter: const ColorFilter.mode(
                  // Color(0xff083437),
                  Colors.black87,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          Tab(
            child: SizedBox(
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
