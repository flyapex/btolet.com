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
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            accountName: const Text('Sabbir 69'),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/a/AAcHTtdx1wQM-1NXgarrI1Ya4-6q0OtKawcqY55DHK3YBw'),
            ),
            accountEmail: const Text(
              'sabbir69@gmail.com',
              style: TextStyle(color: Colors.white),
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
                  Navigator.pop(context);
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
            onTap: () {},
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
                  'Favourite',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.black38,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Calls',
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
                  Icons.place_outlined,
                  color: Colors.black38,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'People Nearby',
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
                  Icons.bookmark_border,
                  color: Colors.black38,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Saved Messages',
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
          const Divider(
            color: Colors.black,
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Invite Friends',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.group,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '24/7 Support',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ),
          InkWell(
            onTap: () {
              // dbController.getUserID();
            },
            child: ListTile(
              title: const Row(
                children: [
                  Icon(
                    Feather.log_out,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'LOGOUT',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ),
        ],
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
