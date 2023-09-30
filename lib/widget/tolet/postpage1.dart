import 'package:btolet/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostPage1 extends StatefulWidget {
  const PostPage1({super.key});

  @override
  State<PostPage1> createState() => _PostPage1State();
}

class _PostPage1State extends State<PostPage1> {
  final PostController postController = Get.find();
  double space = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Looking For',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
