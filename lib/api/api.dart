import 'dart:convert';

import 'package:btolet/model/apimodel.dart';
import 'package:http/http.dart' as http;

var baseUrl = 'https://btolet.com/api';
// var baseUrl = 'http://10.0.2.2:3000/api';

var headers = {
  "content-type": 'application/json;charset=UTF-8',
  'Charset': 'utf-8'
};

class ApiService {
  // loding banner ads api
  static Future banner() async {
    final response = await http.get(Uri.parse("$baseUrl/banner"));
    if (response.statusCode == 200) {
      return bannerListModelFromJson(response.body);
    } else {
      return null;
    }
  }

  // loding notes from api
  static Future notes() async {
    final response = await http.get(Uri.parse("$baseUrl/notes"));
    if (response.statusCode == 200) {
      return notesFromJson(response.body);
    } else {
      return null;
    }
  }

  // check user exist in db or not
  static Future userCheck(email) async {
    var response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({"email": email}),
      headers: headers,
    );
    print(response.body);
    print(response.body.isEmpty);
    if (response.statusCode == 200 && jsonDecode(response.body).isEmpty) {
      return null;
    } else {
      return userDetailsFromJson(response.body)[0];
    }
  }

//NEW USER
  static Future createNewUser(Newuser data) async {
    var response = await http.post(
      Uri.parse('$baseUrl/signup'),
      body: newuserToJson(data),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return nweuserResFromJson(response.body).insertId;
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

  static Future newPostTolet(PostToServerTolet data) async {
    var response = await http.post(
      Uri.parse('$baseUrl/newpostTolet'),
      body: postToServerToletToJson(data),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future profileUpdateapi(ProfileUpdate data) async {
    var response = await http.post(
      Uri.parse('$baseUrl/profileUpdate'),
      body: profileUpdateToJson(data),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
