import 'package:btolet/constants/colors.dart';
import 'package:btolet/controller/db_controller.dart';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/home/home.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MapLoading extends StatefulWidget {
  const MapLoading({super.key});

  @override
  State<MapLoading> createState() => _MapLoadingState();
}

class _MapLoadingState extends State<MapLoading> {
  @override
  void initState() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print("Device Online");
      } else {
        print("Device Ofline");
      }
    });
    super.initState();
  }

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

    Future getBannerAds() async {
      if (userController.fatchOneTime.value) {
        await userController.bannerApi();
        // decodedImages = decodeImages();
      }
    }

    getBannerAds();

    return Obx(
      () => locationController.isLoading.value
          ? Scaffold(
              backgroundColor: Colors.white,
              body: CustomRefreshIndicator(
                key: userController.refreshkeyUser,
                completeStateDuration: const Duration(milliseconds: 450),
                builder: MaterialIndicatorDelegate(
                  backgroundColor: Colors.blueAccent,
                  builder: (context, controller) {
                    return SizedBox(
                      child: LottieBuilder.asset(
                        'assets/lottie/ref.json',
                      ),
                    );
                  },
                ),
                onRefresh: () async {
                  if (userController.banneradsList.isEmpty) {
                    getBannerAds();
                  }
                },
                child: Stack(
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
                                          fontSize: s4,
                                          height: 0.9,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: userController.name.value
                                                .toLowerCase(),
                                            style: const TextStyle(
                                              fontSize: s4,
                                              height: 0.9,
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
                                      fontSize: s4,
                                      color: Color(0xffa1adb7),
                                      height: 0.9,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Container(
                    //     height: 20,
                    //     decoration: const BoxDecoration(
                    //       color: Colors.grey,
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         'Connection Status: ${userController.connectionStatus}',
                    //         style: const TextStyle(
                    //           fontSize: s4,
                    //           height: 0.5,
                    //           color: Colors.white,
                    //         ),
                    //       ).paddingOnly(bottom: 3),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            )
          : const Home(),
    );
  }
}
