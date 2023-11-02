import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/pages/property.dart';
import 'package:btolet/pages/tolet.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
                SavedProperty(),
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
                  // Show a loading indicator
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                } else {
                  return ListView.builder(
                    // key: UniqueKey(),
                    // physics: const NeverScrollableScrollPhysics(),
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length + 1,
                    itemBuilder: (c, i) {
                      if (i < snapshot.data.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: PostsTolet(
                            postData: snapshot.data[i],
                            isLikedvalue: true,
                          ),
                        );
                      } else {
                        if (userController.savedPostToletloding.value) {
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
