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

  // RxBool showMapBoxTolet = false.obs;

  RxDouble currentlatitude = 0.0.obs;
  RxDouble currentlongitude = 0.0.obs;
  RxBool isLoading = true.obs;

  getCurrnetlanlongLocation() async {
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
    // print(currentlatitude.value);
    // print(currentlongitude.value);
    await coordinateToLocationDetails(
      currentlatitude.value,
      currentlongitude.value,
    );
  }

  void onMyLocationButtonPressed() {
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
  coordinateToLocationDetails(double latitude, double longitude) async {
    try {
      var response = await GoogleMapApi.coordinateToLocationDetailsapi(
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

  // var currentPostCountP = 999.obs;
  // Future getCurrentPostCountP(location) async {
  //   try {
  //     var response = await ApiService.postCountAreaP(location);
  //     if (response != null) {
  //       currentPostCountP.value = response;
  //     }
  //   } finally {}
  // }

  // var mapToletList = [].obs;
  // var mapLoding = true.obs;
  // Future mapApi() async {
  //   try {
  //     mapToletList.clear();
  //     mapLoding(true);
  //     var response = await ApiService.mapTolet();
  //     if (response != null) {
  //       mapToletList.addAll(response);

  //       return response;
  //     }
  //   } finally {}
  // }

  // var mapPostToletList = [].obs;
  // var mapPostLoding = true.obs;
  // Future mapPostApi(geolat, geolon) async {
  //   try {
  //     mapPostToletList.clear();
  //     mapPostLoding(true);
  //     var response = await ApiService.codinateTopost(geolat, geolon);
  //     if (response != null) {
  //       mapPostToletList.addAll(response);
  //       mapPostLoding(false);
  //       return response;
  //     }
  //   } finally {}
  // }

  // var mapPostProList = [].obs;
  // var mapPostProLoding = true.obs;
  // Future mapPostApiPro(geolat, geolon) async {
  //   try {
  //     mapPostProList.clear();
  //     mapPostProLoding(true);
  //     var response = await ApiService.codinateTopostp(geolat, geolon);
  //     if (response != null) {
  //       mapPostProList.addAll(response);
  //       mapPostProLoding(false);
  //       return response;
  //     }
  //   } finally {}
  // }

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
