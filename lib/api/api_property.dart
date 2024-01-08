import 'dart:convert';
import 'package:btolet/model/api.dart';
import 'package:btolet/model/pro_model.dart';
import 'package:dio/dio.dart';

final dio = Dio();
var baseUrl = 'http://10.0.2.2:3000/api/pro';
// var baseUrl = 'http://109.123.234.150/api';

class ApiServicePro {
  static Future postCountArea(location) async {
    final response = await dio.get(
      '$baseUrl/postcount/area',
      queryParameters: {"currentLocation": location},
    );

    if (response.statusCode == 200) {
      return postCountFromJson(jsonEncode(response.data)).postCount;
    } else {
      return null;
    }
  }

  static Future getPost(page, geolat, geolon) async {
    final response = await dio.get(
      '$baseUrl/postlist',
      queryParameters: {
        "page": page,
        "geolat": geolat.toString(),
        "geolon": geolon.toString(),
      },
    );

    if (response.statusCode == 200) {
      return postListProFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future getSinglePost(postid) async {
    final response = await dio.get(
      '$baseUrl/post',
      queryParameters: {"pid": postid},
    );

    if (response.statusCode == 200) {
      return singlePostModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future newPost(NewPostPro data) async {
    final response = await dio.post(
      '$baseUrl/newPost',
      data: newPostProToJson(data),
    );

    print(response.data);
    if (response.statusCode == 200) {
      return response.data.toString();
    } else {
      return null;
    }
  }

  static Future sortingPostCount(SortPostPro data) async {
    print(sortPostProToJson(data));
    final response = await dio.post(
      '$baseUrl/sort/postcount',
      data: sortPostProToJson(data),
    );
    print(response.data);
    if (response.statusCode == 200) {
      return response.data['total_count'];
    } else {
      return null;
    }
  }
}
