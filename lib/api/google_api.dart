import 'dart:convert';

import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/model/map_model.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class FacebookSignIn {
  void fblogin() async {}
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> signOut() => _googleSignIn.signOut();
}

LocationController locationController = Get.find();
ToletController toletController = Get.find();
ProController proController = Get.put(ProController());

class GoogleMapApi {
  static Future getCoordinateToLocation(
      double latitude, double longitude) async {
    var response = await dio.get(
      "http://154.26.130.64/nominatim/reverse.php",
      queryParameters: {
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'format': 'jsonv2',
        'accept-language': 'bn'
      },
    );

    if (response.statusCode == 200) {
      var data = response.data;
      // print(data);
      // print('------------------------------------------------');
      var suburb = data["address"]["suburb"];
      var name = data["name"];
      var city = data["address"]["city"];
      var stateDistrict = data["address"]["state_district"];

      // print(suburb);
      // print(name);
      // print(city);
      // print(stateDistrict);
      if (suburb != null && city != null) {
        locationController.locationAddressShort.value = suburb + ", " + city;
      } else if (name != null && city != null) {
        locationController.locationAddressShort.value = name + ", " + city;
      } else if (stateDistrict != null && name != null) {
        locationController.locationAddressShort.value =
            name + ", " + stateDistrict;
      } else {
        locationController.locationAddressShort.value =
            data['display_name'].split(',')[0] +
                ", " +
                data['display_name'].split(',')[1];
      }

      if (locationController.locationAddressShort.value.isNotEmpty) {
        await toletController.getCurrentPostCount();
        await proController.getCurrentPostCount();
      }
      return data['display_name'].toString();
    } else {
      return null;
    }
  }

  static Future coordinateToLocationOnly(
      double latitude, double longitude) async {
    var response = await dio.get(
      "http://154.26.130.64/nominatim/reverse.php",
      queryParameters: {
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'format': 'jsonv2',
        'accept-language': 'bn'
      },
    );

    if (response.statusCode == 200) {
      var data = response.data;
      return data['display_name'].toString();
    } else {
      return null;
    }
  }

  static Future searchSuggstion(searchText) async {
    // print('---------------------------------------------------------');

    final response = await dio.get(
      'http://154.26.130.64/nominatim/search.php',
      queryParameters: {
        'q': searchText,
        'format': 'jsonv2',
        'accept-language': 'bn',
      },
    );

    // print(searchText);
    // print(response);
    if (response.statusCode == 200) {
      return searchModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }
}
