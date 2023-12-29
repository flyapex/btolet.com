import 'package:btolet/controller/location_controller.dart';
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

class GoogleMapApi {
  // static Future searchSuggstion(searchText) async {
  //   print('---------------------------------------------------------');

  //   final Map<String, String> queryParams = {
  //     'q': searchText,
  //     'accept-language': 'en-us',
  //     'countrycodes': 'bd',
  //     'limit': '10',
  //     'format': 'jsonv2',
  //   };
  //   final response = await http.get(
  //     Uri.https('nominatim.openstreetmap.org', '/search.php?').replace(
  //       queryParameters: queryParams,
  //     ),
  //   );

  //   print(searchText);
  //   print(response);
  //   if (response.statusCode == 200) {
  //     return mapSuggstionModelFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // static Future coordinateToLocationDetailsapi(
  //     double latitude, double longitude) async {
  //   // String singleString = latitude.toString() + ',' + longitude.toString();

  //   // final Map<String, String> queryParams = {
  //   //   'lat': latitude.toString(),
  //   //   'lon': longitude.toString(),
  //   //   'zoom': '18',
  //   //   'accept-language': 'en-us',
  //   //   'format': 'jsonv2',
  //   // };
  //   // final response = await http.get(
  //   //   Uri.https('nominatim.openstreetmap.org', '/reverse.php?').replace(
  //   //     queryParameters: queryParams,
  //   //   ),
  //   // );

  //   final Map<String, String> queryParams = {
  //     'lat': latitude.toString(),
  //     'lon': longitude.toString(),
  //   };

  //   final response = await http.get(
  //     Uri.https(
  //       'geocode.maps.co',
  //       '/reverse?',
  //     ).replace(queryParameters: queryParams),
  //   );

  //   if (response.statusCode == 200) {
  //     // print(response.body);
  //     Map<String, dynamic> data = jsonDecode(response.body);

  //     // String displayName = data['display_name'];
  //     // String city = data['address']['city'];
  //     // print('-----------------------------------------------------');
  //     // print('Display Name: $displayName');
  //     // print(data['address']['city']);
  //     // print(data['address']['suburb']);
  //     // print(data['address']['suburb']['city']);
  //     // print(response.body);

  //     var suburb = data["address"]["suburb"];
  //     var city = data["address"]["city"];
  //     locationController.locationAddressShort.value = suburb + ", " + city;
  //     // print(city);
  //     if (locationController.locationAddress.value.isNotEmpty) {
  //       locationController.getCurrentPostCount(city);
  //     }
  //     // print(city);
  //     return data['display_name'].toString();

  //     // return mapSuggstionModelFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }
  static Future coordinateToLocationDetailsapi(
      double latitude, double longitude) async {
    // String singleString = latitude.toString() + ',' + longitude.toString();

    // final Map<String, String> queryParams = {
    //   'lat': latitude.toString(),
    //   'lon': longitude.toString(),
    //   'zoom': '18',
    //   'accept-language': 'en-us',
    //   'format': 'jsonv2',
    // };
    // final response = await http.get(
    //   Uri.https('nominatim.openstreetmap.org', '/reverse.php?').replace(
    //     queryParameters: queryParams,
    //   ),
    // );

    // var response = await dio.get(
    //   "https://api.bigdatacloud.net/data/reverse-geocode-client",
    //   queryParameters: {
    //     'latitude': latitude.toString(),
    //     'longitude': longitude.toString(),
    //     'localityLanguage': 'en',
    //   },
    // );
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

      var suburb = data["address"]["suburb"];
      var city = data["address"]["city"];
      locationController.locationAddressShort.value = suburb + ", " + city;

      if (locationController.locationAddress.value.isNotEmpty) {
        locationController.getCurrentPostCount(city);
        locationController.getCurrentPostCountP(city);
      }
      return data['display_name'].toString();
    } else {
      return null;
    }
  }

  //  List<Placemark> placemarks = await placemarkFromCoordinates(
  //     latitude,
  //     longitude,
  //   );
  //   Placemark placeMark = placemarks[0];

  //   print('-------------------------------------------------');
  //   print(placeMark.toString());
  // print(placeMark.name);
  // print(placeMark.street);
  // print(placeMark.isoCountryCode);
  // print(placeMark.country);
  // print(placeMark.postalCode);
  // print(placeMark.administrativeArea);
  // print(placeMark.subAdministrativeArea);
  // print(placeMark.locality);
  // print(placeMark.subLocality);
  // print(placeMark.thoroughfare);
  // print(placeMark.subThoroughfare);
  // return placeMark.locality;
}
