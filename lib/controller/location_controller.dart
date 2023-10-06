import 'package:btolet/api/google_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class LocationController extends GetxController {
  late GoogleMapController mapController;

  RxBool mapMode = false.obs;

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
    coordinateToLocationDetails(currentlatitude.value, currentlongitude.value);
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

  RxBool isLoadingsuggstion = false.obs;
  var suggstions = [].obs;
  var searchText = ''.obs;
  searchSuggstion() async {
    try {
      isLoadingsuggstion.value = true;
      var response = await GoogleMapApi.searchSuggstion(
          searchText.value == '' ? locationAddress.value : searchText.value);
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

  RxBool cordinateToLocationLoding = true.obs;
  coordinateToLocationDetails(double latitude, double longitude) async {
    try {
      var response = await GoogleMapApi.coordinateToLocationDetailsapi(
          latitude, longitude);
      if (response != null) {
        // return response;
        // searchController.text = response;
        // searchController.selection = TextSelection(
        //   baseOffset: 0,
        //   extentOffset: response.length,
        // );
        locationAddress.value = response;
      } else {
        print("Error");
      }
    } finally {
      cordinateToLocationLoding.value = false;
    }
  }

  //---------------Multi map
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  final markerList = [
    [
      'Nirala Residential Area',
      22.798499,
      89.552697,
      'Khulna',
    ],
    [
      'Khulna',
      22.798222,
      89.555208,
      'Khulna',
    ]
  ];

  Future<Uint8List> createMarkerImageFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
