import 'package:btolet/controller/db_controller.dart';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MapLoading extends StatelessWidget {
  const MapLoading({super.key});

  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.put(LocationController());
    UserController userController = Get.put(UserController());
    final DBController dbController = Get.put(DBController());

    getUserDetails() async {
      await userController.userDetailsByID(await dbController.getUserID());
      await locationController.getCurrnetlanlongLocation(
          false, "Map Loding Main");
    }

    getUserDetails();

    return Obx(
      () => locationController.isLoading.value
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                alignment: Alignment.center,
                children: [
                  // const LocationSheet(),
                  Container(
                    color: Colors.white,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        userController.name.value.isEmpty
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'welcome ',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black45,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: userController.name.value
                                              .toLowerCase(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Lottie.asset(
                                        'assets/lottie/smile.json',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            child: Lottie.asset(
                              'assets/lottie/location.json',
                            ),
                          ),
                        ),
                        const SizedBox(),
                        const SizedBox(),
                        const Column(
                          children: [
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Color(0xffa1adb7),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  'Locating you',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffa1adb7),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Home(),
    );
  }
}
