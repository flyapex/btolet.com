import 'package:btolet/api/api.dart';
import 'package:btolet/api/google_api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  late GoogleMapController mapController;

  RxBool mapMode = false.obs;
  RxBool showMapBoxTolet = false.obs;

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
    await coordinateToLocationDetails(
        currentlatitude.value, currentlongitude.value);
  }

  void onMyLocationButtonPressed() {
    LatLng location = LatLng(
      currentlatitude.value,
      currentlongitude.value,
    );
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

  // RxBool isLoadingsuggstion = false.obs;
  // var suggstions = [].obs;
  // var searchText = ''.obs;
  // searchSuggstion() async {
  //   try {
  //     isLoadingsuggstion.value = true;
  //     var response = await GoogleMapApi.searchSuggstion(
  //         searchText.value == '' ? locationAddress.value : searchText.value);
  //     if (response != null) {
  //       suggstions.clear();
  //       suggstions.addAll(response);
  //     } else {
  //       print("Error");
  //     }
  //   } finally {
  //     isLoadingsuggstion.value = false;
  //   }
  // }

  RxBool cordinateToLocationLoding = true.obs;
  coordinateToLocationDetails(double latitude, double longitude) async {
    try {
      var response = await GoogleMapApi.coordinateToLocationDetailsapi(
        latitude,
        longitude,
      );
      if (response != null) {
        // print('-------------------------------------------------');
        // print(response.name);
        // print(response.street);
        // print(response.isoCountryCode);
        // print(response.country);
        // print(response.postalCode);
        // print(response.administrativeArea);
        // print(response.subAdministrativeArea);
        // print(response.locality);
        // print(response.subLocality);
        // print(response.thoroughfare);
        // print(response.subThoroughfare);
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

  //---------------Multi map

  var mapToletList = [].obs;
  var mapLoding = false.obs;
  Future mapApi() async {
    try {
      mapToletList.clear();
      mapLoding(true);
      var response = await ApiService.mapTolet();
      if (response != null) {
        mapToletList.addAll(response);
        mapLoding(false);
        return response;
      }
    } finally {}
  }
}
