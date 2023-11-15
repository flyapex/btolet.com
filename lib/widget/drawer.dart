import 'package:btolet/controller/db_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/pages/drawer/myads.dart';
import 'package:btolet/pages/drawer/mypost.dart';
import 'package:btolet/pages/drawer/profile.dart';
import 'package:btolet/pages/drawer/saved.dart';
import 'package:btolet/pages/drawer/termsandcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class CustomeDrawer extends StatefulWidget {
  const CustomeDrawer({super.key});

  @override
  State<CustomeDrawer> createState() => _CustomeDrawerState();
}

class _CustomeDrawerState extends State<CustomeDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  UserController userController = Get.find();
  DBController dbController = Get.find();

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.lightBlue),
              accountName: Text(
                  "${userController.name.value} (${dbController.getUserID()})"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(userController.image.value),
              ),
              accountEmail: Text(
                userController.email.value,
                style: const TextStyle(color: Colors.white),
              ),
              otherAccountsPictures: [
                IconButton(
                  icon: Icon(
                    Get.isDarkMode ? Icons.brightness_2 : Icons.wb_sunny,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  onPressed: () async {
                    Get.back();
                  },
                  icon: const Icon(
                    Feather.toggle_right,
                    color: Colors.white,
                    size: 25,
                  ),
                )
              ],
            ),

            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Feather.user,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              onTap: () {
                Get.to(
                  () => const Profile(),
                  transition: Transition.circularReveal,
                  duration: const Duration(milliseconds: 500),
                );
              },
            ),
            ListTile(
              onTap: () {
                // Navigator.pop(context);
                // Get.bottomSheet(
                //   const Verify(),
                //   elevation: 20.0,
                //   enableDrag: true,
                //   backgroundColor: Colors.white,
                //   isScrollControlled: true,
                //   ignoreSafeArea: true,
                //   shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(20.0),
                //       topRight: Radius.circular(20.0),
                //     ),
                //   ),
                //   enterBottomSheetDuration: const Duration(milliseconds: 170),
                // );

                Get.to(
                  () => const Saved(),
                  transition: Transition.circularReveal,
                  duration: const Duration(milliseconds: 500),
                );
              },
              title: const Row(
                children: [
                  Icon(
                    Feather.heart,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Saved',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Feather.edit,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'My Post',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              onTap: () {
                Get.to(
                  () => const MyPost(),
                  transition: Transition.circularReveal,
                  duration: const Duration(milliseconds: 500),
                );
              },
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.auto_fix_high_outlined,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'My Ads',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              onTap: () {
                Get.to(
                  () => const Myads(),
                  transition: Transition.circularReveal,
                  duration: const Duration(milliseconds: 500),
                );
              },
            ),

            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Feather.radio,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Feedback',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Feather.help_circle,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'FAQ',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              onTap: () {},
            ),
            Container(
              height: 0.3,
              color: Colors.black45,
            ),
            ListTile(
              title: InkWell(
                onTap: () {
                  Get.to(const Terms());
                },
                child: const Row(
                  children: [
                    Icon(
                      Feather.search,
                      color: Colors.black38,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Terms & Condition',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: const Row(
                  children: [
                    Icon(
                      Feather.phone_call,
                      color: Colors.black38,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Contact Us',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Feather.alert_circle,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'About us',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              onTap: () {},
            ),
            // InkWell(
            //   onTap: () {
            //     // dbController.getUserID();
            //   },
            //   child: ListTile(
            //     title: const Row(
            //       children: [
            //         Icon(
            //           Feather.log_out,
            //           color: Colors.black38,
            //         ),
            //         SizedBox(
            //           width: 30,
            //         ),
            //         Text(
            //           'LOGOUT',
            //           style: TextStyle(color: Colors.black),
            //         ),
            //       ],
            //     ),
            //     onTap: () {},
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTilePressed;

  const DrawerListTile(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.onTilePressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
