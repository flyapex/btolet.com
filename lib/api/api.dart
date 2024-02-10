import 'dart:convert';
import 'package:btolet/model/api.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'google ads/ad_helper.dart';

final dio = Dio();
var baseUrl = url;

// var baseUrl = 'http://10.0.2.2:3000/api';
// var baseUrl = 'http://154.26.135.41:3800/api';

var headers = {
  "content-type": 'application/json;charset=UTF-8',
  'charset': 'utf-8',
  // 'Connection': 'keep-alive',
};

class ApiService {
  static Future banner() async {
    final response = await dio.get("$baseUrl/banner");
    if (response.statusCode == 200) {
      return bannerListModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future notes() async {
    final response = await dio.get("$baseUrl/notes");
    if (response.statusCode == 200) {
      return notesFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future profileUpdateapi(ProfileUpdate data) async {
    // print('$baseUrl/user/profile/update');
    // print(jsonEncode(data));
    Response response = await dio.post(
      '$baseUrl/user/profile/update',
      data: profileUpdateToJson(data),
    );

    if (response.statusCode == 200) {
      return response.data['message'];
    } else {
      return null;
    }
  }

//NEW USER
  static Future userLogin(Newuser data) async {
    print('$baseUrl/login');
    print(jsonEncode(data));
    var response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: newuserToJson(data),
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(response);
      return userDetailsFromJson(response.body)[0];
    } else {
      return null;
    }
  }

  // on lunch app get user details by uid
  static Future userdetails(uid) async {
    var response = await http.post(
      Uri.parse('$baseUrl/uid'),
      body: jsonEncode({"uid": uid}),
      headers: headers,
    );

    if (response.statusCode == 200 && jsonDecode(response.body).isEmpty) {
      return null;
    } else {
      return userDetailsFromJson(response.body)[0];
    }
  }
}
