import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class FeedBack extends StatelessWidget {
  const FeedBack({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FeedBack',
          style: TextStyle(
            fontSize: s1,
            height: 0.5,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7),
            // fontFamily: 'Roboto',
          ),
        ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Row(
          children: [
            Icon(
              Feather.navigation,
              color: Colors.black54,
              size: 18,
            ),
            SizedBox(width: 10),
            Text(
              'Send',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Feedback wanted! Enhance our app? Suggestions for extra features? Let us know! ✨',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Image',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: const Color(0xffE3E8FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Feather.camera,
                color: Colors.black45,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Description(
            title: "Text",
            textType: TextInputType.text,
            hintText: "\nFeedback Here✨",
            controller: userController.description,
            icon: Feather.file_text,
            focusNode: userController.descriptionfocusNode,
          ),
        ],
      ).paddingOnly(left: 20, right: 20),
    );
  }
}

class Description extends StatefulWidget {
  final String title;
  final IconData icon;
  final String hintText;
  final TextInputType textType;
  final TextEditingController controller;
  final FocusNode focusNode;
  const Description(
      {Key? key,
      required this.title,
      required this.icon,
      required this.hintText,
      required this.textType,
      required this.controller,
      required this.focusNode})
      : super(key: key);

  @override
  DescriptionState createState() => DescriptionState();
}

class DescriptionState extends State<Description> {
  UserController userController = Get.find();
  var textstyle = const TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    // fontSize: s2,
    fontFamily: 'Roboto',
    fontSize: 14,
  );
  var textstyleh = TextStyle(
    overflow: TextOverflow.fade,
    height: 1.2,
    // fontSize: s2,
    // letterSpacing: 1.2,
    fontFamily: 'Roboto',
    fontSize: 14,
    color: Colors.black.withOpacity(0.3),
  );
  var iconColorChange = false;
  var focusNode = FocusNode();
  getFocus() {
    if (widget.focusNode == userController.descriptionfocusNode) {
      FocusScope.of(context).requestFocus(userController.phonefocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            letterSpacing: 0.7,
            fontSize: s3,
          ),
        ),
        const SizedBox(height: 15),
        InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(focusNode);
          },
          child: Container(
            height: 170,
            width: Get.width,
            decoration: BoxDecoration(
              color: const Color(0xffF2F3F5),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    margin: const EdgeInsets.only(left: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      widget.icon,
                      color: iconColorChange
                          ? Colors.blueAccent
                          : Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Expanded(
                    child: Focus(
                      onFocusChange: (val) {
                        setState(() {
                          val
                              ? iconColorChange = true
                              : iconColorChange = false;
                        });
                      },
                      child: TextField(
                        // textAlignVertical: TextAlignVertical.top,
                        // textAlign: TextAlign.center,
                        focusNode: widget.focusNode,
                        cursorHeight: 28,
                        cursorWidth: 1.8,
                        cursorRadius: const Radius.circular(10),
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 100,
                        controller: widget.controller,
                        textInputAction: TextInputAction.newline,
                        cursorColor: Colors.black,
                        style: textstyle,

                        decoration: InputDecoration(
                          // contentPadding:
                          //     EdgeInsets.only(top: !iconColorChange ? 0 : 30),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                          hintText: iconColorChange ? '' : widget.hintText,
                          hintStyle: textstyleh,
                        ),
                        onChanged: (v) {},
                        onSubmitted: (v) {
                          getFocus();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
