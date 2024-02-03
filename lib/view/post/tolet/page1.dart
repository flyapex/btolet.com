import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/post/input_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'widget/catagory_body.dart';
import 'widget/chips.dart';
import 'widget/imagepicker.dart';
import 'widget/text_input.dart';

class PostTolet1 extends StatefulWidget {
  const PostTolet1({super.key});

  @override
  State<PostTolet1> createState() => PostToletState1();
}

class PostToletState1 extends State<PostTolet1> {
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
                  toletController.pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                ),
                label: const Text(
                  "NEXT",
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
        controller: toletController.scrollControllerPost,
        padding: const EdgeInsets.only(left: 20, right: 20),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInput(
              topPadding: 0,
              title: "Property Name",
              textType: TextInputType.text,
              hintText: "Masud Monjil",
              titlelenth: 500,
              suffixtext: "",
              controller: toletController.nameController,
              iconh: 23,
              iconw: 23,
              svgicon: '',
              focusNode: toletController.namefocusNode,
            ),
            SizedBox(height: space),
            Text(
              'Category *',
              style: TextStyle(
                fontSize: s3,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                (toletController.categories.length / 3).ceil(),
                (columnIndex) {
                  final start = columnIndex * 3;
                  final end = (columnIndex + 1) * 3;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: toletController.categories.entries
                        .toList()
                        .sublist(start, end)
                        .map((entry) {
                      final category = entry.key;
                      final categoryState = entry.value;
                      return CategoryChip(
                        category: category,
                        categoryState: categoryState,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const CategoryBody(),
            SizedBox(height: space),
            const Text(
              'Select image *',
              style: TextStyle(
                fontSize: s3,
                color: Color(0xff7B7B7B),
                letterSpacing: 0.7,
              ),
            ),
            const SizedBox(height: 10),
            const ImagePicker(
              icon: Feather.camera,
              imagnumber: 12,
            ),
            SizedBox(height: space),
            Description(
              title: "Description",
              textType: TextInputType.text,
              hintText:
                  '''\nফুল টাইলস,পর্যাপ্ত আলোবাতাস এবং সিসিটিভি সিকিউরিটি। 
রাত ১১ টার পরে গেট বন্ধ হয়ে যাবে।''',
              // hintText: '',
              controller: userController.description,
              icon: Feather.file_text,
              focusNode: userController.descriptionfocusNode,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
