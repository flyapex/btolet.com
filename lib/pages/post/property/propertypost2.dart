import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/model/postmodel.dart';
import 'package:btolet/widget/btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import 'widget/btn.dart';

class PostProperty2 extends StatefulWidget {
  const PostProperty2({super.key});

  @override
  State<PostProperty2> createState() => _PostProperty2State();
}

class _PostProperty2State extends State<PostProperty2> {
  final PostController postController = Get.find();

  double space = 20.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
            ? const SizedBox()
            : SizedBox(
                width: 140,
                height: 45,
                child: FloatingActionButton.extended(
                  foregroundColor: const Color(0xff5E72E4),
                  shape: RoundedRectangleBorder(
                      // side: const BorderSide(width: 3, color: Colors.red),
                      borderRadius: BorderRadius.circular(100)),
                  elevation: 0,
                  onPressed: () async {},
                  icon: const Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Post Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LocationSmall(),
                SmallTextBox(
                  topPadding: 0,
                  title: "Short Address",
                  textType: TextInputType.streetAddress,
                  hintText: "Uttara sector 16, Road-3, Dhaka",
                  titlelenth: 500,
                  suffixtext: "",
                  controller: postController.shortAddress,
                  iconh: 23,
                  iconw: 23,
                  widthh: 2.35 / 2,
                ),
                SizedBox(height: space),
                DescriptionTextBox(
                  title: "Description *",
                  textType: TextInputType.text,
                  hintText:
                      "\nSpecify house condition, extra features and house etc👀",
                  controller: postController.description,
                  icon: Feather.file_text,
                ),
                const SizedBox(height: 30),
                const Text(
                  'You are',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                SelectableChipsType(
                  categorylist: postedBy,
                ),
                const SizedBox(height: 20),
                Text(
                  'Connect with others',
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 1,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, right: 20),
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xffF6F7FC),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    "https://lh3.googleusercontent.com/a/AAcHTtdx1wQM-1NXgarrI1Ya4-6q0OtKawcqY55DHK3YBw",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Feather.camera,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: FullTextInputBoxTemp(
                        topPadding: 10,
                        bottomPadding: 6,
                        title: 'Name',
                        textType: TextInputType.name,
                        hintText: "Sabbir Cudna",
                        controller: postController.name,
                        icon: 'assets/icons/text.svg',
                        iconh: 21,
                        iconw: 21,
                      ),
                    ),
                  ],
                ),
                NumberBox(
                  topPadding: 15,
                  bottomPadding: 6,
                  title: "Phone",
                  textType: TextInputType.number,
                  hintText: '013XXXX',
                  controller: postController.number,
                  icon: 'assets/icons/call.svg',
                  iconh: 21,
                  iconw: 21,
                  color: const Color(0xff6E7FFC),
                ),
                NumberBox(
                  topPadding: 10,
                  bottomPadding: 6,
                  title: "WhatsApp",
                  textType: TextInputType.number,
                  hintText: '017XXXX',
                  controller: postController.wapp,
                  icon: 'assets/icons/wapp.svg',
                  iconh: 22,
                  iconw: 22,
                  color: Colors.lightGreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
