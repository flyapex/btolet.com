import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'controller/location_controller.dart';
import 'home.dart';
import 'pages/map/location_sheet_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BTolet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MapLodingPage(),
    );
  }
}

class MapLodingPage extends StatelessWidget {
  const MapLodingPage({super.key});

  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.put(LocationController());
    return Obx(
      () => locationController.isLoading.value
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                alignment: Alignment.center,
                children: [
                  const LocationSheet(),
                  Container(
                    color: Colors.white,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(),
                        // Lottie.asset('assets/lottie/location.json'),
                        // Lottie.asset('assets/lottie/globe.json'),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            child: Lottie.asset(
                              'assets/lottie/location.json',
                            ),
                          ),
                        ),

                        const Text(
                          'Welcome Galib',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(),
                        const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const HomeView(),
    );
  }
}
