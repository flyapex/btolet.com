import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/controller/tolet_controller.dart';
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
  static Future coordinateToLocationDetailsapi(
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

      var suburb = data["address"]["suburb"];
      var city = data["address"]["city"];
      locationController.locationAddressShort.value = suburb + ", " + city;

      if (locationController.locationAddress.value.isNotEmpty) {
        await toletController.getCurrentPostCount(city);
        await proController.getCurrentPostCount(city);
      }
      return data['display_name'].toString();
    } else {
      return null;
    }
  }
}
