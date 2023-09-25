import 'package:btolet/property.dart';
import 'package:btolet/toletpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import 'post_btn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xff161a2d),
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
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
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));
  double wt = Get.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SlideTransition(
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
                onPressed: () {},
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.cyanAccent, Colors.yellow],
                ),
                strokeWidth: 4,
                radius: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.add),
                    const SizedBox(width: 6),
                    Text(
                      'POST',
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
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: NestedScrollView(
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
                        onPressed: () {},
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
                            splashColor: Colors.black12,
                            child: Row(
                              children: [
                                Text(
                                  'Khulna',
                                  style: TextStyle(
                                    color: const Color(0xff1A3259)
                                        .withOpacity(0.8),
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.dotted,
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
                            onTap: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                  actions: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Material(
                        child: InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(Icons.search, size: 28),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Material(
                          child: InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(FontAwesome.sliders, size: 26),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Material(
                          child: InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Feather.message_square, size: 26),
                            ),
                            onTap: () {},
                          ),
                        ),
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
              children: [
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
                  child: const ToletPage(),
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
                  child: const PropertyPage(),
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
  CustomTab(this.size);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      height: size,
      child: const TabBar(
        // indicatorWeight: 3,
        // indicatorColor: Colors.white,
        // labelColor: Colors.white,
        // unselectedLabelColor: Colors.white60,
        // isScrollable: true,
        tabs: <Widget>[
          Tab(icon: Icon(Feather.radio)),
          Tab(icon: Icon(Icons.business_outlined)),
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
