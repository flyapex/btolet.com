import 'dart:convert';
import 'package:btolet/model/api.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

final dio = Dio();
var baseUrl = 'http://10.0.2.2:3000/api';
// var baseUrl = 'http://109.123.234.150/api';

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
  // static Future profileUpdateapi(UserUpdate data) async {
  //   final response = await dio.get(
  //     "$baseUrl/profileUpdate",
  //     queryParameters: userupto(data),
  //   );

  //   if (response.statusCode == 200) {
  //     return response.body;
  //   } else {
  //     return null;
  //   }
  // }

  //*------------------------------------------------------------

  // static Future postCountAreaP(location) async {
  //   Response response = await dio.get(
  //     '$baseUrl/property/postcount/area',
  //     queryParameters: {"currentLocation": location},
  //   );

  //   if (response.statusCode == 200) {
  //     return response.data['postCount'];
  //   } else {
  //     return null;
  //   }
  // }

//NEW USER
  static Future userLogin(Newuser data) async {
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

  static Future newPostTolet(PostToServerTolet data) async {
    var response = await http.post(
      Uri.parse('$baseUrl/newpostTolet'),
      body: postToServerToletToJson(data),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  // static Future getSinglePostTolet(postid) async {
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/tolet/post"),
  //     headers: headers,
  //     body: jsonEncode({"post_id": postid}),
  //   );
  //   if (response.statusCode == 200) {
  //     return toletSinglePostFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // static Future mapTolet() async {
  //   final response = await http.get(Uri.parse("$baseUrl/map/posts"));
  //   if (response.statusCode == 200) {
  //     return mapToletFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // static Future codinateTopost(geolat, geolon) async {
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/map/postid"),
  //     headers: headers,
  //     body: jsonEncode(
  //       {
  //         "geolat": geolat.toString(),
  //         "geolon": geolon.toString(),
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     return mapPostToletFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // static Future codinateTopostp(geolat, geolon) async {
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/map/postid"),
  //     headers: headers,
  //     body: jsonEncode(
  //       {
  //         "geolat": geolat.toString(),
  //         "geolon": geolon.toString(),
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     return mapPostToletFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // static Future sortingPostCount(data) async {
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/sort/postcount"),
  //     headers: headers,
  //     body: data,
  //   );

  //   if (response.statusCode == 200) {
  //     data = json.decode(response.body);
  //     final int totalCount = data['total_count'];
  //     print(data['total_count']);
  //     return totalCount;
  //   } else {
  //     return null;
  //   }
  // }

  // // static Future sortingPost(data) async {
  // //   final response = await http.post(
  // //     Uri.parse("$baseUrl/sort/postlist"),
  // //     headers: headers,
  // //     body: sortingPostToJson(data),
  // //   );
  // //   if (response.statusCode == 200) {
  // //     return toletPostListFromJson(response.body);
  // //   } else {
  // //     return null;
  // //   }
  // // }

  // static Future savedPostTolet(int uid, int pid, bool status) async {
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/savetolet"),
  //     headers: headers,
  //     body: jsonEncode(
  //       {
  //         "uid": uid,
  //         "pid": pid,
  //         "status": status,
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // static Future getsavedPostTolet(int page, int uid) async {
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/getsavedtoletpostlist"),
  //     headers: headers,
  //     body: jsonEncode(
  //       {
  //         "uid": uid,
  //         "page": page,
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     return myPostListToletFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // static Future getMypostTolet(int page, int uid) async {
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/user/mypostTolet"),
  //     headers: headers,
  //     body: jsonEncode(
  //       {
  //         "uid": uid,
  //         "page": page,
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     return myPostListToletFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // static Future getMypostDeleteTolet(int uid, int postId) async {
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/user/delete/mypostTolet"),
  //     headers: headers,
  //     body: jsonEncode(
  //       {
  //         "uid": uid,
  //         "post_id": postId,
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // static Future newPostProperty(NewPostProperty data) async {
  //   var response = await http.post(
  //     Uri.parse('$baseUrl/property/newpost'),
  //     body: newPostPropertyToJson(data),
  //     headers: headers,
  //   );
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   } else {
  //     return null;
  //   }
  // }

  // static Future getAllPropertyPost(page, geolat, geolon) async {
  //   Response response = await dio.get(
  //     "$baseUrl/property/postlist",
  //     queryParameters: {
  //       "page": page,
  //       "geolat": geolat.toString(),
  //       "geolon": geolon.toString(),
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     return propertyListFromJson(jsonEncode(response.data));
  //   } else {
  //     return null;
  //   }
  // }

  // static Future savedPropertyPost(int uid, int pid, bool status) async {
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/property/save"),
  //     headers: headers,
  //     body: jsonEncode(
  //       {
  //         "uid": uid,
  //         "pid": pid,
  //         "status": status,
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // static Future getSinglePostPropertyApi(pid) async {
  //   Response response = await dio.get(
  //     "$baseUrl/property/singlepost",
  //     queryParameters: {"pid": pid},
  //   );

  //   if (response.statusCode == 200) {
  //     return propertySinglePostFromJson(jsonEncode(response.data));
  //   } else {
  //     return null;
  //   }
  // }
}
