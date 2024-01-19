import 'dart:convert';
import 'package:btolet/model/api.dart';
import 'package:btolet/model/tolet_model.dart';
import 'package:dio/dio.dart';

final dio = Dio();
var baseUrl = 'http://10.0.2.2:3000/api/tolet';
// var baseUrl = 'http://154.26.135.41:3800/api/tolet';

var headers = {
  "content-type": 'application/json;charset=UTF-8',
  'charset': 'utf-8',
  // 'Connection': 'keep-alive',
};

class ApiServiceTolet {
  static Future postCountArea(location1, location2) async {
    final response = await dio.get(
      '$baseUrl/postcount/area',
      queryParameters: {
        "location1": location1,
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
      return postListToletFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future getSinglePost(postid) async {
    final response = await dio.get(
      '$baseUrl/post',
      queryParameters: {"post_id": postid},
    );

    if (response.statusCode == 200) {
      return singleToletPostModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future getMorePost(
      postid, category, price, page, geolat, geolon) async {
    // var data = jsonEncode(
    //   {
    //     "postid": postid,
    //     "category": category,
    //     "price": price,
    //     "page": page,
    //     "geolat": geolat.toString(),
    //     "geolon": geolon.toString(),
    //   },
    // );
    // print(data);

    final response = await dio.post(
      '$baseUrl/more/post',
      data: {
        "postid": postid,
        "category": category,
        "price": price,
        "page": page,
        "geolat": geolat.toString(),
        "geolon": geolon.toString(),
      },
    );

    if (response.statusCode == 200) {
      return postListToletFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future newPost(NewPostTolet data) async {
    final response = await dio.post(
      '$baseUrl/newPost',
      data: newPostToletToJson(data),
    );

    if (response.statusCode == 200) {
      return response.data.toString();
    } else {
      return null;
    }
  }

  static Future sortingPostCount(SortPostTolet data) async {
    final response = await dio.post(
      '$baseUrl/sort/postcount',
      data: sortPostToletToJson(data),
    );

    if (response.statusCode == 200) {
      return response.data['total_count'];
    } else {
      return null;
    }
  }

  static Future sortingPost(SortPostTolet data) async {
    final response = await dio.post(
      '$baseUrl/sort/postlist',
      data: sortPostToletToJson(data),
    );

    if (response.statusCode == 200) {
      return postListToletFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future savedPost(int uid, int pid, bool status) async {
    print({"uid": uid, "pid": pid, "status": status});
    final response = await dio.post(
      '$baseUrl/save/post',
      data: {
        "uid": uid,
        "pid": pid,
        "status": status,
      },
    );

    if (response.statusCode == 200) {
      print(response.data);
    } else {
      return null;
    }
  }

  static Future getSaved(int uid, int page) async {
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
      return postListToletFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future myPostList(int uid, int page) async {
    final response = await dio.get(
      '$baseUrl/user/mypost',
      queryParameters: {
        "uid": uid,
        "page": page,
      },
    );

    if (response.statusCode == 200) {
      // return myPostListToletFromJson(jsonEncode(response.data));
      return postListToletFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future deletePost(int uid, int postId) async {
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
      return mapToletModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future codinateTopost(geolat, geolon) async {
    final response = await dio.get(
      '$baseUrl/map/postid',
      queryParameters: {
        "geolat": geolat.toString(),
        "geolon": geolon.toString()
      },
    );

    if (response.statusCode == 200) {
      return postListToletFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }
}
