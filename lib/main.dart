import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'controller/db_controller.dart';
import 'home.dart';
import 'pages/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 0D8D49BE872F9CDB19FA9A709F0500DC
  MobileAds.instance.initialize();
  MobileAds.instance
    ..initialize()
    ..updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: [
        '0D8D49BE872F9CDB19FA9A709F0500DC',
        '6AE4A6FCA1ACDDF6DF236166FAD1D606'
      ]),
    );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    final dbController = Get.put(DBController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BTolet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),

      home: dbController.getUserID() == false
          ? const LoginPage()
          : const MapLodingPage(),
      // home: const MapLodingPage(),
      // home: const LoginPage(),
    );
  }
}
