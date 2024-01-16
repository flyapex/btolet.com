import 'package:btolet/api/google_api.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  var singlePostTolemap = true.obs;
  var singlePostPromap = true.obs;
  UserController userController = Get.put(UserController());

  RxBool mapModetolet = false.obs;
  RxBool mapModePro = false.obs;

  late AnimationController animationController;

  resetAnimation(val) {
    mapModetolet(val);
    mapModePro(val);
    if (val) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  animation(val) {
    if (val) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  swapMap() {
    if (userController.tabController.index == 0) {
      mapModetolet.value = !mapModetolet.value;
      animation(mapModetolet.value);
    } else {
      mapModePro.value = !mapModePro.value;
      animation(mapModePro.value);
    }
  }

  late GoogleMapController mapController;

  RxDouble currentlatitude = 0.0.obs;
  RxDouble currentlongitude = 0.0.obs;

  RxBool isLoading = true.obs;

  getCurrnetlanlongLocation(bool mapAnimation, v) async {
    print(v);
    print("Get Current Location");
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('', 'Location Permission Denied');
        return Future.error('Location permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentlatitude.value = position.latitude;
    currentlongitude.value = position.longitude;
    isLoading.value = false;
    await coordinateToLocation(
      currentlatitude.value,
      currentlongitude.value,
    );
    if (mapAnimation) {
      onMyLocationButtonPressed();
    }
  }

  void onMyLocationButtonPressed() async {
    // await getCurrnetlanlongLocation();
    LatLng location = LatLng(
      currentlatitude.value,
      currentlongitude.value,
    );
    // print(location);
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            location.latitude,
            location.longitude,
          ),
          zoom: 16.0,
        ),
      ),
    );
  }

  TextEditingController searchController = TextEditingController();
  RxString locationAddress = ''.obs;
  RxString locationAddressShort = 'Location'.obs;

  RxBool cordinateToLocationLoding = true.obs;
  coordinateToLocation(double latitude, double longitude) async {
    try {
      var response = await GoogleMapApi.getCoordinateToLocation(
        latitude,
        longitude,
      );
      if (response != null) {
        currentlatitude.value = latitude;
        currentlongitude.value = longitude;
        locationAddress.value = response;
      } else {
        print("Error");
      }
    } finally {
      cordinateToLocationLoding.value = false;
    }
  }

  RxBool isLoadingsuggstion = false.obs;
  var suggstions = [].obs;
  var searchText = ''.obs;
  searchSuggstion() async {
    try {
      isLoadingsuggstion.value = true;
      var response = await GoogleMapApi.searchSuggstion(searchText.value == ''
          ? locationAddressShort.value
          : searchText.value);
      if (response != null) {
        suggstions.clear();
        suggstions.addAll(response);
      } else {
        print("Error");
      }
    } finally {
      isLoadingsuggstion.value = false;
    }
  }
}
