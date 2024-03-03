import 'package:btolet/api/google_api.dart';
import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:btolet/view/map/location_post.dart';
import 'package:btolet/view/post/input_user.dart';
import 'package:btolet/view/post/pro/widget/text_input.dart';
import 'package:btolet/view/post/tolet/widget/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import 'widget/chips.dart';

class PostPro2 extends StatefulWidget {
  const PostPro2({super.key});

  @override
  State<PostPro2> createState() => PostToletState1();
}

class PostToletState1 extends State<PostPro2> {
  ProController proController = Get.find();
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
                    // side: const BorderSide(width: 3, color: Colors.red),
                    borderRadius: BorderRadius.circular(100)),
                elevation: 0,
                onPressed: () async {
                  proController.activeFlag.value = true;
                  Vibration.vibrate(pattern: [10, 20, 10]);
                  proController.flagCheck();
                  if (proController.allFlag.value) {
                    Get.back();
                    print('--------------Posting Now------------------');
                    var res = await proController.newpost();
                    await userController.snakberSuccess(res);
                    proController.resetAllflag();
                    Future.delayed(const Duration(seconds: 2)).then((val) {
                      proController.refreshkey.currentState!.refresh(
                        draggingDuration: const Duration(milliseconds: 350),
                        draggingCurve: Curves.easeOutBack,
                      );
                    });
                  } else {
                    proController.checkAllCatagory();
                    // await userController.snakberSuccess('Missing Someting ✨!');
                  }
                  // if (proController.selectedCategory.value == category[0] ||
                  //     proController.selectedCategory.value == category[1]) {
                  //   proController.protypeFlag(true);
                  //   proController.areaFlag(true);
                  //   proController.rodeSizeFlag(true);
                  //   proController.flagCheck();

                  //   if (proController.allFlag.value) {
                  //     print('--------------Posting Now------------------');
                  //     Get.back();
                  //     var res = await proController.newpost();
                  //     await userController.snakberSuccess(res);
                  //     proController.resetAllflag();
                  //   } else {
                  //     proController.protypeFlag(false);
                  //     proController.areaFlag(false);
                  //     proController.rodeSizeFlag(false);
                  //     proController.flagCheck();
                  //   }
                  // } else {
                  //   proController.diningFlag(true);
                  //   proController.kitchenFlag(true);
                  //   proController.facingFlag(true);
                  //   proController.totalfloorFlag(true);
                  //   proController.floornumberFlag(true);
                  //   proController.totalsizeFlag(true);
                  //   proController.totalUnitFlag(true);
                  //   proController.floornumberFlag(true);
                  //   proController.flagCheck();

                  //   if (proController.allFlag.value) {
                  //     print('--------------Posting Now------------------');
                  //     Get.back();
                  //     var res = await proController.newpost();
                  //     await userController.snakberSuccess(res);
                  //     proController.resetAllflag();
                  //   } else {
                  //     proController.diningFlag(false);
                  //     proController.kitchenFlag(false);
                  //     proController.facingFlag(false);
                  //     proController.totalfloorFlag(false);
                  //     proController.floornumberFlag(false);
                  //     proController.totalsizeFlag(false);
                  //     proController.totalUnitFlag(false);
                  //     proController.floornumberFlag(false);
                  //     proController.flagCheck();
                  //   }
                  // }
                  // if (proController.allFlag.value) {
                  //   print('--------------Posting Now------------------');
                  //   Get.back();
                  //   var res = await proController.newpost();
                  //   await userController.snakberSuccess(res);
                  //   proController.activeFlag(false);
                  //   proController.diningFlag(false);
                  //   proController.kitchenFlag(false);
                  //   proController.facingFlag(false);
                  //   proController.totalUnitFlag(false);
                  //   proController.totalsizeFlag(false);
                  //   proController.totalfloorFlag(false);
                  //   proController.floornumberFlag(false);
                  //   proController.priceFlag(false);
                  //   proController.imageFlag(false);
                  //   proController.protypeFlag(false);
                  //   proController.areaFlag(false);
                  //   proController.mesurementFlag(false);
                  //   proController.rodeSizeFlag(false);

                  //   proController.dining.value = 'select';
                  //   proController.kitchen.value = 'select';
                  //   proController.facing.value = 'select';
                  //   proController.area.value = 'শতাংশ';
                  //   proController.allFlag.value = false;
                  // } else {}
                },
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                ),
                label: const Text(
                  'Post Now',
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
            TextInputPro(
              topPadding: 0,
              title: "Short Address",
              textType: TextInputType.streetAddress,
              hintText: "Uttara sector 16, Road-3, Dhaka",
              textlength: 500,
              suffixtext: "",
              controller: userController.shortAddress,
              widthh: 2.35 / 2,
              focusNode: userController.shortaddressfocusNode,
            ),
            SizedBox(height: space),
            Description(
              title: "Description *",
              textType: TextInputType.text,
              hintText:
                  "\nSpecify house condition, extra features and house etc👀",
              controller: userController.description,
              icon: Feather.file_text,
              focusNode: userController.descriptionfocusNode,
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
                    focusNode: toletController.namefocusNode,
                  ),
                ),
              ],
            ),
            SizedBox(height: space),
            const Text(
              'You are',
              style: TextStyle(
                fontSize: s1,
                color: Colors.black54,
              ),
            ),
            PorChipsNotext(
              options: postedBy,
              selected: proController.selectedPostedBy,
            ),
            NumberInput(
              topPadding: 15,
              bottomPadding: 6,
              title: "Phone",
              textType: TextInputType.number,
              hintText: '013XXXX',
              controller: userController.phonenumber,
              icon: 'assets/icons/home/call.svg',
              iconh: 21,
              iconw: 21,
              color: const Color(0xff6E7FFC),
              focusNode: userController.phonefocusNode,
              numberLength: 10,
            ),
            NumberInput(
              topPadding: 10,
              bottomPadding: 6,
              title: "WhatsApp",
              textType: TextInputType.number,
              hintText: '017XXXX',
              controller: userController.wappnumber,
              icon: 'assets/icons/home/wapp.svg',
              iconh: 30,
              iconw: 30,
              color: Colors.lightGreen,
              focusNode: userController.wappfocusNode,
              numberLength: 10,
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
