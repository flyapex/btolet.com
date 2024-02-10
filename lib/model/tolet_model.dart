// To parse this JSON data, do
//
//     final postListTolet = postListToletFromJson(jsonString);

import 'dart:convert';

List<PostListTolet> postListToletFromJson(String str) =>
    List<PostListTolet>.from(
        json.decode(str).map((x) => PostListTolet.fromJson(x)));

String postListToletToJson(List<PostListTolet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostListTolet {
  final int postId;
  List<String> category;
  final int uid;
  final String bed;
  final String bath;
  final String roomsize;
  final String kitchen;
  final int rent;
  final String garagetype;
  final String image1;
  final String location;
  final DateTime time;
  final double? distance;
  final int totalImage;
  PostListTolet({
    required this.postId,
    required this.category,
    required this.uid,
    required this.bed,
    required this.bath,
    required this.roomsize,
    required this.kitchen,
    required this.rent,
    required this.garagetype,
    required this.image1,
    required this.location,
    required this.time,
    required this.distance,
    required this.totalImage,
  });

  factory PostListTolet.fromJson(Map<String, dynamic> json) => PostListTolet(
        postId: json["post_id"],
        category: List<String>.from(json["category"].map((x) => x)),
        uid: json["uid"],
        bed: json["bed"],
        bath: json["bath"],
        roomsize: json["roomsize"],
        kitchen: json["kitchen"],
        rent: json["rent"],
        garagetype: json["garagetype"],
        image1: json["image1"],
        location: json["location"],
        time: DateTime.parse(json["time"]),
        distance: json["distance"]?.toDouble(),
        totalImage: json["total_image"],
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "category": List<dynamic>.from(category.map((x) => x)),
        "uid": uid,
        "bed": bed,
        "bath": bath,
        "roomsize": roomsize,
        "kitchen": kitchen,
        "rent": rent,
        "garagetype": garagetype,
        "image1": image1,
        "location": location,
        "time": time.toIso8601String(),
        "distance": distance,
        "total_image": totalImage,
      };
}

SingleToletPostModel singleToletPostModelFromJson(String str) =>
    SingleToletPostModel.fromJson(json.decode(str));

String singleToletPostModelToJson(SingleToletPostModel data) =>
    json.encode(data.toJson());

class SingleToletPostModel {
  final int postId;
  final int uid;
  final String propertyname;
  List<String> category;
  final String bed;
  final String bath;
  final String balcony;
  final String drawing;
  final String dining;
  final String kitchen;
  final String floornumber;
  final String facing;
  final String roomsize;
  final DateTime rentfrom;
  final int mentenance;
  final int rent;
  final String garagetype;
  List<String> fasalitis;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String image6;
  final String image7;
  final String image8;
  final String image9;
  final String image10;
  final String image11;
  final String image12;
  final String description;
  final String geolon;
  final String geolat;
  final String location;
  final String shortaddress;
  final String phone;
  final String wapp;
  final int click;
  final int payment;
  final int topAds;
  final DateTime time;

  SingleToletPostModel({
    required this.postId,
    required this.uid,
    required this.propertyname,
    required this.category,
    required this.bed,
    required this.bath,
    required this.balcony,
    required this.drawing,
    required this.dining,
    required this.kitchen,
    required this.floornumber,
    required this.facing,
    required this.roomsize,
    required this.rentfrom,
    required this.mentenance,
    required this.rent,
    required this.garagetype,
    required this.fasalitis,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.image6,
    required this.image7,
    required this.image8,
    required this.image9,
    required this.image10,
    required this.image11,
    required this.image12,
    required this.description,
    required this.geolon,
    required this.geolat,
    required this.location,
    required this.shortaddress,
    required this.phone,
    required this.wapp,
    required this.click,
    required this.payment,
    required this.topAds,
    required this.time,
  });

  factory SingleToletPostModel.fromJson(Map<String, dynamic> json) =>
      SingleToletPostModel(
        postId: json["post_id"],
        uid: json["uid"],
        propertyname: json["propertyname"],
        category: List<String>.from(json["category"].map((x) => x)),
        bed: json["bed"],
        bath: json["bath"],
        balcony: json["balcony"],
        drawing: json["drawing"],
        dining: json["dining"],
        kitchen: json["kitchen"],
        floornumber: json["floornumber"],
        facing: json["facing"],
        roomsize: json["roomsize"],
        rentfrom: DateTime.parse(json["rentfrom"]),
        mentenance: json["mentenance"],
        rent: json["rent"],
        garagetype: json["garagetype"],
        fasalitis: List<String>.from(json["fasalitis"].map((x) => x)),
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        image4: json["image4"],
        image5: json["image5"],
        image6: json["image6"],
        image7: json["image7"],
        image8: json["image8"],
        image9: json["image9"],
        image10: json["image10"],
        image11: json["image11"],
        image12: json["image12"],
        description: json["description"],
        geolon: json["geolon"],
        geolat: json["geolat"],
        location: json["location"],
        shortaddress: json["shortaddress"],
        phone: json["phone"],
        wapp: json["wapp"],
        click: json["click"],
        payment: json["payment"],
        topAds: json["top_ads"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "uid": uid,
        "propertyname": propertyname,
        "category": List<dynamic>.from(category.map((x) => x)),
        "bed": bed,
        "bath": bath,
        "balcony": balcony,
        "drawing": drawing,
        "dining": dining,
        "kitchen": kitchen,
        "floornumber": floornumber,
        "facing": facing,
        "roomsize": roomsize,
        "rentfrom": rentfrom.toIso8601String(),
        "mentenance": mentenance,
        "rent": rent,
        "garagetype": garagetype,
        "fasalitis": List<dynamic>.from(fasalitis.map((x) => x)),
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "image4": image4,
        "image5": image5,
        "image6": image6,
        "image7": image7,
        "image8": image8,
        "image9": image9,
        "image10": image10,
        "image11": image11,
        "image12": image12,
        "description": description,
        "geolon": geolon,
        "geolat": geolat,
        "location": location,
        "shortaddress": shortaddress,
        "phone": phone,
        "wapp": wapp,
        "click": click,
        "payment": payment,
        "top_ads": topAds,
        "time": time.toIso8601String(),
      };
}

NewPostTolet newPostToletFromJson(String str) =>
    NewPostTolet.fromJson(json.decode(str));

String newPostToletToJson(NewPostTolet data) => json.encode(data.toJson());

class NewPostTolet {
  final int uid;
  final String propertyname;
  List<String> category;
  final String bed;
  final String bath;
  final String balcony;
  final String drawing;
  final String dining;
  final String kitchen;
  final String floornumber;
  final String facing;
  final String roomsize;
  final DateTime rentfrom;
  final int mentenance;
  final int rent;
  final String garagetype;
  List<String> fasalitis;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String image6;
  final String image7;
  final String image8;
  final String image9;
  final String image10;
  final String image11;
  final String image12;
  final String description;
  final String geolon;
  final String geolat;
  final String location;
  final String locationfull;
  final String shortaddress;
  final String phone;
  final String wapp;

  NewPostTolet({
    required this.uid,
    required this.propertyname,
    required this.category,
    required this.bed,
    required this.bath,
    required this.balcony,
    required this.drawing,
    required this.dining,
    required this.kitchen,
    required this.floornumber,
    required this.facing,
    required this.roomsize,
    required this.rentfrom,
    required this.mentenance,
    required this.rent,
    required this.garagetype,
    required this.fasalitis,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.image6,
    required this.image7,
    required this.image8,
    required this.image9,
    required this.image10,
    required this.image11,
    required this.image12,
    required this.description,
    required this.geolon,
    required this.geolat,
    required this.location,
    required this.locationfull,
    required this.shortaddress,
    required this.phone,
    required this.wapp,
  });

  factory NewPostTolet.fromJson(Map<String, dynamic> json) => NewPostTolet(
        uid: json["uid"],
        propertyname: json["propertyname"],
        category: List<String>.from(json["category"].map((x) => x)),
        bed: json["bed"],
        bath: json["bath"],
        balcony: json["balcony"],
        drawing: json["drawing"],
        dining: json["dining"],
        kitchen: json["kitchen"],
        floornumber: json["floornumber"],
        facing: json["facing"],
        roomsize: json["roomsize"],
        rentfrom: DateTime.parse(json["rentfrom"]),
        mentenance: json["mentenance"],
        rent: json["rent"],
        garagetype: json["garagetype"],
        fasalitis: List<String>.from(json["fasalitis"].map((x) => x)),
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        image4: json["image4"],
        image5: json["image5"],
        image6: json["image6"],
        image7: json["image7"],
        image8: json["image8"],
        image9: json["image9"],
        image10: json["image10"],
        image11: json["image11"],
        image12: json["image12"],
        description: json["description"],
        geolon: json["geolon"],
        geolat: json["geolat"],
        location: json["location"],
        locationfull: json["locationfull"],
        shortaddress: json["shortaddress"],
        phone: json["phone"],
        wapp: json["wapp"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "propertyname": propertyname,
        "category": List<dynamic>.from(category.map((x) => x)),
        "bed": bed,
        "bath": bath,
        "balcony": balcony,
        "drawing": drawing,
        "dining": dining,
        "kitchen": kitchen,
        "floornumber": floornumber,
        "facing": facing,
        "roomsize": roomsize,
        "rentfrom": rentfrom.toIso8601String(),
        "mentenance": mentenance,
        "rent": rent,
        "garagetype": garagetype,
        "fasalitis": List<dynamic>.from(fasalitis.map((x) => x)),
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "image4": image4,
        "image5": image5,
        "image6": image6,
        "image7": image7,
        "image8": image8,
        "image9": image9,
        "image10": image10,
        "image11": image11,
        "image12": image12,
        "description": description,
        "geolon": geolon,
        "geolat": geolat,
        "location": location,
        "locationfull": locationfull,
        "shortaddress": shortaddress,
        "phone": phone,
        "wapp": wapp,
      };
}

SortPostTolet sortPostToletFromJson(String str) =>
    SortPostTolet.fromJson(json.decode(str));

String sortPostToletToJson(SortPostTolet data) => json.encode(data.toJson());

class SortPostTolet {
  String geolat;
  String geolon;
  int page;
  List<String> category;
  List<String> fasalitis;
  int rentmin;
  int rentmax;
  List<String> bed;
  List<String> bath;

  SortPostTolet({
    required this.geolat,
    required this.geolon,
    required this.page,
    required this.category,
    required this.fasalitis,
    required this.rentmin,
    required this.rentmax,
    required this.bed,
    required this.bath,
  });

  factory SortPostTolet.fromJson(Map<String, dynamic> json) => SortPostTolet(
        geolat: json["geolat"],
        geolon: json["geolon"],
        page: json["page"],
        category: List<String>.from(json["category"].map((x) => x)),
        fasalitis: List<String>.from(json["fasalitis"].map((x) => x)),
        rentmin: json["rentmin"],
        rentmax: json["rentmax"],
        bed: List<String>.from(json["bed"].map((x) => x)),
        bath: List<String>.from(json["bath"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "geolat": geolat,
        "geolon": geolon,
        "page": page,
        "category": List<dynamic>.from(category.map((x) => x)),
        "fasalitis": List<dynamic>.from(fasalitis.map((x) => x)),
        "rentmin": rentmin,
        "rentmax": rentmax,
        "bed": List<dynamic>.from(bed.map((x) => x)),
        "bath": List<dynamic>.from(bath.map((x) => x)),
      };
}

// // To parse this JSON data, do
// //
// //     final myPostListTolet = myPostListToletFromJson(jsonString);

// List<MyPostListTolet> myPostListToletFromJson(String str) =>
//     List<MyPostListTolet>.from(
//         json.decode(str).map((x) => MyPostListTolet.fromJson(x)));

// String myPostListToletToJson(List<MyPostListTolet> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class MyPostListTolet {
//   int postId;
//   int uid;
//   String bed;
//   String bath;
//   String roomsize;
//   String kitchen;
//   int rent;
//   String garagetype;
//   String image1;
//   String location;
//   DateTime time;

//   MyPostListTolet({
//     required this.postId,
//     required this.uid,
//     required this.bed,
//     required this.bath,
//     required this.roomsize,
//     required this.kitchen,
//     required this.rent,
//     required this.garagetype,
//     required this.image1,
//     required this.location,
//     required this.time,
//   });

//   factory MyPostListTolet.fromJson(Map<String, dynamic> json) =>
//       MyPostListTolet(
//         postId: json["post_id"],
//         uid: json["uid"],
//         bed: json["bed"],
//         bath: json["bath"],
//         roomsize: json["roomsize"],
//         kitchen: json["kitchen"],
//         rent: json["rent"],
//         garagetype: json["garagetype"],
//         image1: json["image1"],
//         location: json["location"],
//         time: DateTime.parse(json["time"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "post_id": postId,
//         "uid": uid,
//         "bed": bed,
//         "bath": bath,
//         "roomsize": roomsize,
//         "kitchen": kitchen,
//         "rent": rent,
//         "garagetype": garagetype,
//         "image1": image1,
//         "location": location,
//         "time": time.toIso8601String(),
//       };
// }
// To parse this JSON data, do
//
//     final toletSinglePost = toletSinglePostFromJson(jsonString);

// To parse this JSON data, do
//
//     final mapToletModel = mapToletModelFromJson(jsonString);

List<MapToletModel> mapToletModelFromJson(String str) =>
    List<MapToletModel>.from(
        json.decode(str).map((x) => MapToletModel.fromJson(x)));

String mapToletModelToJson(List<MapToletModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MapToletModel {
  int postId;
  String geolon;
  String geolat;
  int rent;

  MapToletModel({
    required this.postId,
    required this.geolon,
    required this.geolat,
    required this.rent,
  });

  factory MapToletModel.fromJson(Map<String, dynamic> json) => MapToletModel(
        postId: json["post_id"],
        geolon: json["geolon"],
        geolat: json["geolat"],
        rent: json["rent"],
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "geolon": geolon,
        "geolat": geolat,
        "rent": rent,
      };
}
