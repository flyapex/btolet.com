import 'dart:convert';
import 'package:btolet/model/map.dart';
import 'package:http/http.dart' as http;

class GoogleMapApi {
  static Future searchSuggstion(searchText) async {
    print('---------------------------------------------------------');

    final Map<String, String> queryParams = {
      'q': searchText,
      'accept-language': 'en-us',
      'countrycodes': 'bd',
      'limit': '10',
      'format': 'jsonv2',
    };
    final response = await http.get(
      Uri.https('nominatim.openstreetmap.org', '/search.php?').replace(
        queryParameters: queryParams,
      ),
    );

    print(searchText);
    print(response);
    if (response.statusCode == 200) {
      return mapSuggstionModelFromJson(response.body);
    } else {
      return null;
    }
  }

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

    final Map<String, String> queryParams = {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
    };

    final response = await http.get(
      Uri.https(
        'geocode.maps.co',
        '/reverse?',
      ).replace(queryParameters: queryParams),
    );

    if (response.statusCode == 200) {
      // print(response.body);
      Map<String, dynamic> data = jsonDecode(response.body);

      // String displayName = data['display_name'];
      // String city = data['address']['city'];
      // print('-----------------------------------------------------');
      // print('Display Name: $displayName');
      // // print('City: $city');
      return data['display_name'].toString();

      // return mapSuggstionModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
