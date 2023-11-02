import 'package:btolet/controller/db_controller.dart';
import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    DBController dbController = Get.find();
    PostController postController = Get.find();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Feather.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: InkWell(
          onTap: () async {
            var res = await postController.updateProfile();
            await postController.snakberSuccess(res);
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Center(
              child: Text(
                "Update Porfile",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: Get.height - 110,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 250),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CircleAvatar(
                                minRadius: 50,
                                maxRadius: 50,
                                backgroundImage: NetworkImage(
                                  userController.image.value,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userController.name.value,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "(${dbController.getUserID()})",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            userController.email.value,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5),
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(
                            thickness: 4,
                            color: Colors.black.withOpacity(0.1),
                          ),
                          const SizedBox(height: 20),
                          TextInputBoxProfile(
                            topPadding: 0,
                            title: "Name",
                            textType: TextInputType.text,
                            hintText: userController.name.value,
                            suffixtext: "",
                            controller: postController.nameTolet,
                            iconh: 23,
                            iconw: 23,
                          ),
                          TextInputBoxProfile(
                            topPadding: 20,
                            title: "Phone",
                            textType: TextInputType.number,
                            hintText: userController.name.value,
                            suffixtext: "",
                            controller: postController.phonenumberTolet,
                            iconh: 23,
                            iconw: 23,
                          ),
                          TextInputBoxProfile(
                            topPadding: 20,
                            title: "Whatsapp",
                            textType: TextInputType.number,
                            hintText: userController.name.value,
                            suffixtext: "",
                            controller: postController.wappnumberTolet,
                            iconh: 23,
                            iconw: 23,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextInputBoxProfile extends StatefulWidget {
  final String title;
  final String hintText;
  final String suffixtext;
  final TextInputType textType;
  final double topPadding;
  final TextEditingController controller;
  final double iconh;
  final double iconw;

  const TextInputBoxProfile({
    super.key,
    required this.title,
    required this.hintText,
    required this.suffixtext,
    required this.textType,
    required this.topPadding,
    required this.controller,
    required this.iconh,
    required this.iconw,
  });

  @override
  State<TextInputBoxProfile> createState() => _TextInputBoxProfileState();
}

class _TextInputBoxProfileState extends State<TextInputBoxProfile> {
  UserController userController = Get.find();
  var textstyle = TextStyle(
    overflow: TextOverflow.ellipsis,
    color: Colors.black.withOpacity(0.5),
    height: 1.2,
    fontSize: 16,
    letterSpacing: 1.2,
  );
  var textstyleh = TextStyle(
    overflow: TextOverflow.ellipsis,
    height: 1.2,
    fontSize: 15,
    letterSpacing: 1.2,
    color: Colors.black.withOpacity(0.5),
  );
  var iconColorChange = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.topPadding),
        Text(
          widget.title,
          style: TextStyle(
            letterSpacing: 0.7,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffF2F3F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black.withOpacity(0.04)),
          ),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: Focus(
                    onFocusChange: (val) {
                      setState(() {
                        val ? iconColorChange = true : iconColorChange = false;
                      });
                    },
                    child: TextField(
                      // maxLength: widget.titlelenth,
                      cursorHeight: 24,
                      cursorWidth: 1.8,
                      cursorRadius: const Radius.circular(10),
                      controller: widget.controller,
                      textInputAction: TextInputAction.next,
                      keyboardType: widget.textType,
                      maxLines: 1,
                      cursorColor: Colors.black,
                      style: textstyle,
                      decoration: InputDecoration(
                        suffix: Text(
                          widget.suffixtext,
                          style: TextStyle(
                            color: iconColorChange
                                ? const Color(0xff0166EE)
                                : Colors.amber,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                        hintText: widget.hintText,
                        hintStyle: textstyleh,
                      ),
                      onChanged: (val) {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
