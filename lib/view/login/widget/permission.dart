import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Permission extends StatelessWidget {
  const Permission({super.key});

  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.put(LocationController());
    checkPermission() async {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar('', 'Location Permission Denied');
          return Future.error('Location permissions are denied');
        }
      }
      print(permission);
      if (permission == LocationPermission.whileInUse) {
        locationController.getCurrnetlanlongLocation(false, 'home');
        Get.offAll(
          const Home(),
          transition: Transition.circularReveal,
          duration: const Duration(milliseconds: 600),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                child: Lottie.asset(
                  'assets/lottie/globe.json',
                  repeat: false,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  const Text(
                    'Enable Location Permission',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'To get great service you need to provide location permission. You can always change permission from settings.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(),
            const SizedBox(),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: Get.height / 17,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        checkPermission();
                      },
                      label: const Text(
                        'Give Permissions',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      elevation: 0.2,
                      backgroundColor: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
