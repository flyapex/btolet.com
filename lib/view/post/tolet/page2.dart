import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/map/location_post.dart';
import 'package:btolet/view/post/input_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import 'widget/text_input.dart';

class PostTolet2 extends StatefulWidget {
  const PostTolet2({super.key});

  @override
  State<PostTolet2> createState() => PostToletState1();
}

class PostToletState1 extends State<PostTolet2> {
  ToletController toletController = Get.find();
  UserController userController = Get.find();

  double space = 20.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    borderRadius: BorderRadius.circular(100)),
                elevation: 0,
                onPressed: () async {
                  toletController.activeFlag.value = true;
                  Vibration.vibrate(pattern: [10, 20, 10]);
                  toletController.flagCheck();
                  if (toletController.allFlag.value) {
                    Get.back();
                    print('--------------Posting Now------------------');
                    var res = await toletController.newpost();
                    await userController.snakberSuccess(res);
                    toletController.resetAllflag();
                    Future.delayed(const Duration(seconds: 2)).then((val) {
                      toletController.refreshkey.currentState!.refresh(
                        draggingDuration: const Duration(milliseconds: 350),
                        draggingCurve: Curves.easeOutBack,
                      );
                    });
                  } else {
                    // toletController.checkAllCatagory();
                    // await userController.snakberSuccess('Missing Someting ✨!');
                  }
                },
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
                    fontSize: s4,
                  ),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Location(),
            TextInput(
              topPadding: 0,
              title: "Short Address",
              textType: TextInputType.streetAddress,
              hintText: "Uttara sector 16, Road-3, Dhaka",
              titlelenth: 500,
              suffixtext: "",
              controller: userController.shortAddress,
              iconh: 23,
              iconw: 23,
              svgicon: '',
              focusNode: userController.shortaddressfocusNode,
            ),
            SizedBox(height: space),
            Text(
              'Your Details',
              style: TextStyle(
                fontSize: s3,
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
                            image: DecorationImage(
                              image: NetworkImage(userController.image.value),
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
                  child: TextInput(
                    topPadding: 10,
                    title: 'Name',
                    textType: TextInputType.name,
                    hintText: "Sabbir",
                    controller: userController.nameController,
                    iconh: 23,
                    iconw: 23,
                    svgicon: 'assets/icons/home/text.svg',
                    suffixtext: '',
                    titlelenth: 500,
                    focusNode: userController.namefocusNode,
                  ),
                ),
              ],
            ),
            NumberInput(
              topPadding: 15,
              bottomPadding: 6,
              title: "Phone *",
              textType: TextInputType.number,
              hintText: '013XXXX',
              controller: userController.phonenumber,
              icon: 'assets/icons/home/call.svg',
              iconh: 21,
              iconw: 21,
              color: const Color(0xff6E7FFC),
              focusNode: userController.phonefocusNode,
              numberLength: 11,
            ),
            NumberInput(
              topPadding: 10,
              bottomPadding: 6,
              title: "WhatsApp",
              textType: TextInputType.number,
              hintText: '017XXXX',
              controller: userController.wappnumber,
              icon: 'assets/icons/home/wapp.svg',
              iconh: 28,
              iconw: 28,
              color: Colors.lightGreen,
              focusNode: userController.wappfocusNode,
              numberLength: 11,
            ),
          ],
        ),
      ),
    );
  }
}
