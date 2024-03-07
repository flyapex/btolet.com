import 'dart:convert';
import 'package:btolet/model/pro_model.dart';
import 'package:btolet/model/user_model.dart';
import 'package:dio/dio.dart';

import 'google ads/ad_helper.dart';

final dio = Dio();
var baseUrl = '$url/pro';
// var baseUrl = 'http://10.0.2.2:3000/api/pro';
// var baseUrl = 'http://154.26.135.41:3800/api/pro';

class ApiServicePro {
  static Future postCountArea(location, location2) async {
    final response = await dio.get(
      '$baseUrl/postcount/area',
      queryParameters: {
        "location1": location,
        "location2": location2,
      },
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

    if (response.statusCode == 200 && jsonEncode(response.data).isNotEmpty) {
      return singlePostModelProFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future getMorePost(postid, category, page, geolat, geolon) async {
    // var data = jsonEncode(
    //   {
    //     "postid": postid,
    //     "category": category,
    //     "page": page,
    //     "geolat": geolat.toString(),
    //     "geolon": geolon.toString(),
    //   },
    // );
    // print('$baseUrl/more/post');
    // print(data);
    final response = await dio.post(
      '$baseUrl/more/post',
      data: {
        "postid": postid,
        "category": category,
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

  // static Future newPost(NewPostPro data) async {
  //   final response = await dio.post(
  //     '$baseUrl/newpost',
  //     data: newPostProToJson(data),
  //   );

  //   if (response.statusCode == 200) {
  //     print(response);
  //     return response.data.toString();
  //   } else {
  //     return null;
  //   }
  // }

  static Future newPost(NewPostPro data) async {
    print('$baseUrl/newPost');
    print(newPostProToJson(data));
    try {
      final response = await dio.post(
        '$baseUrl/newpost',
        data: newPostProToJson(data),
      );

      if (response.statusCode == 200) {
        print(response);
        return response.data.toString();
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print('----------');
      print(e.toString());
    }
  }

  static Future sortingPostCount(SortPostPro data) async {
    // print('$baseUrl/sort/postcount');
    // print(sortPostProToJson(data));
    // print({
    //   "geolat": data.geolat,
    //   "geolon": data.geolon,
    //   "page": data.page,
    //   "category": List<dynamic>.from(data.category.map((x) => x)),
    //   "fasalitis": List<dynamic>.from(data.fasalitis.map((x) => x)),
    //   "rentmin": data.rentmin,
    //   "rentmax": data.rentmax,
    //   "bed": List<dynamic>.from(data.bed.map((x) => x)),
    //   "bath": List<dynamic>.from(data.bath.map((x) => x)),
    // });
    final response = await dio.post(
      '$baseUrl/sort/postcount',
      data: sortPostProToJson(data),
      // queryParameters: {
      //   "geolat": data.geolat,
      //   "geolon": data.geolon,
      //   "page": data.page,
      //   "category": List<dynamic>.from(data.category.map((x) => x)),
      //   "fasalitis": List<dynamic>.from(data.fasalitis.map((x) => x)),
      //   "rentmin": data.rentmin,
      //   "rentmax": data.rentmax,
      //   "bed": List<dynamic>.from(data.bed.map((x) => x)),
      //   "bath": List<dynamic>.from(data.bath.map((x) => x)),
      // },
    );

    if (response.statusCode == 200) {
      return response.data['total_count'];
    } else {
      return null;
    }
  }

  static Future sortingPost(SortPostPro data) async {
    // print('$baseUrl/sort/postlist');
    // print(sortPostProToJson(data));
    final response = await dio.post(
      '$baseUrl/sort/postlist',
      data: sortPostProToJson(data),
      // queryParameters: {
      //   "geolat": data.geolat,
      //   "geolon": data.geolon,
      //   "page": data.page,
      //   "category": List<dynamic>.from(data.category.map((x) => x)),
      //   "fasalitis": List<dynamic>.from(data.fasalitis.map((x) => x)),
      //   "rentmin": data.rentmin,
      //   "rentmax": data.rentmax,
      //   "bed": List<dynamic>.from(data.bed.map((x) => x)),
      //   "bath": List<dynamic>.from(data.bath.map((x) => x)),
      // },
    );

    if (response.statusCode == 200) {
      return postListProFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future savedPost(int uid, int pid, bool status) async {
    // print('$baseUrl/save/post');
    // print(jsonEncode(
    //   {
    //     "uid": uid,
    //     "pid": pid,
    //     "status": status,
    //   },
    // ));
    final response = await dio.post(
      '$baseUrl/save/post',
      data: jsonEncode(
        {
          "uid": uid,
          "pid": pid,
          "status": status,
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.data);
    } else {
      return null;
    }
  }

  static Future getSaved(int uid, int page) async {
    // print('$baseUrl/save/post/get');
    // print({
    //   "uid": uid,
    //   "page": page,
    // });
    final response = await dio.post(
      '$baseUrl/save/post/get',
      data: jsonEncode(
        {
          "uid": uid,
          "page": page,
        },
      ),
    );
    // print(response);
    if (response.statusCode == 200) {
      return postListProFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future myPostList(int uid, int page) async {
    // print('$baseUrl/user/mypost');
    final response = await dio.get(
      '$baseUrl/user/mypost',
      queryParameters: {
        "uid": uid,
        "page": page,
      },
    );

    if (response.statusCode == 200) {
      return postListProFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future deletePost(int uid, int postId) async {
    // print(uid);
    // print(postId);

    final response = await dio.delete(
      '$baseUrl/user/mypost/delete',
      queryParameters: {
        "uid": uid,
        "post_id": postId,
      },
    );

    if (response.statusCode == 200) {
      print(response.data);
    } else {
      return null;
    }
  }

  static Future map() async {
    final response = await dio.get(
      '$baseUrl/map/posts',
    );

    if (response.statusCode == 200) {
      return mapProModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future codinateTopost(geolat, geolon) async {
    final response = await dio.get(
      '$baseUrl/map/postlist',
      queryParameters: {
        "geolat": geolat.toString(),
        "geolon": geolon.toString()
      },
    );

    if (response.statusCode == 200) {
      return mapProPostListModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }
}
