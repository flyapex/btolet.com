import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/pages/tolet.dart';
import 'package:btolet/widget/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class ToletSortPage extends StatefulWidget {
  const ToletSortPage({super.key});

  @override
  State<ToletSortPage> createState() => _ToletSortPageState();
}

class _ToletSortPageState extends State<ToletSortPage> {
  PostController postController = Get.find();
  final scrollController = ScrollController();
  @override
  void initState() {
    postController.getAllSortedPost();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("You're at the top.");
        } else {
          print("You're at the bottom.");
          postController.getAllSortedPost();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    postController.allToletSortedPost.clear();
    postController.toletsortpage.value = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sorted Post'),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                StreamBuilder(
                  stream: postController.allToletSortedPost.stream,
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
                              child: PostsTolet(
                                postData: snapshot.data[i],
                              ),
                            );
                          } else {
                            if (postController.toletsortlodingPosts.value) {
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
