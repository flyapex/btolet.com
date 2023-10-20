import 'dart:convert';

// To parse this JSON data, do
//
//     final bannerListModel = bannerListModelFromJson(jsonString);

List<BannerListModel> bannerListModelFromJson(String str) =>
    List<BannerListModel>.from(
        json.decode(str).map((x) => BannerListModel.fromJson(x)));

String bannerListModelToJson(List<BannerListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerListModel {
  BannerListModel({
    required this.bId,
    required this.image,
    required this.text,
    required this.postTime,
  });

  int bId;
  String image;
  String text;
  DateTime postTime;

  factory BannerListModel.fromJson(Map<String, dynamic> json) =>
      BannerListModel(
        bId: json["b_id"],
        image: json["image"],
        text: json["text"],
        postTime: DateTime.parse(json["post_time"]),
      );

  Map<String, dynamic> toJson() => {
        "b_id": bId,
        "image": image,
        "text": text,
        "post_time": postTime.toIso8601String(),
      };
}

Newuser newuserFromJson(String str) => Newuser.fromJson(json.decode(str));

String newuserToJson(Newuser data) => json.encode(data.toJson());

class Newuser {
  String name;
  String email;
  String image;
  String geolocation;
  String signature;

  Newuser({
    required this.name,
    required this.email,
    required this.image,
    required this.geolocation,
    required this.signature,
  });

  factory Newuser.fromJson(Map<String, dynamic> json) => Newuser(
        name: json["name"],
        email: json["email"],
        image: json["image"],
        geolocation: json["geolocation"],
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "image": image,
        "geolocation": geolocation,
        "signature": signature,
      };
}

NweuserRes nweuserResFromJson(String str) =>
    NweuserRes.fromJson(json.decode(str));

String nweuserResToJson(NweuserRes data) => json.encode(data.toJson());

class NweuserRes {
  NweuserRes({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  factory NweuserRes.fromJson(Map<String, dynamic> json) => NweuserRes(
        fieldCount: json["fieldCount"],
        affectedRows: json["affectedRows"],
        insertId: json["insertId"],
        info: json["info"],
        serverStatus: json["serverStatus"],
        warningStatus: json["warningStatus"],
      );

  Map<String, dynamic> toJson() => {
        "fieldCount": fieldCount,
        "affectedRows": affectedRows,
        "insertId": insertId,
        "info": info,
        "serverStatus": serverStatus,
        "warningStatus": warningStatus,
      };
}
// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

List<UserDetails> userDetailsFromJson(String str) => List<UserDetails>.from(
    json.decode(str).map((x) => UserDetails.fromJson(x)));

String userDetailsToJson(List<UserDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDetails {
  int uid;
  String name;
  String email;
  String image;
  String phone;
  String wapp;
  String geolocation;
  String signature;
  DateTime time;

  UserDetails({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.phone,
    required this.wapp,
    required this.geolocation,
    required this.signature,
    required this.time,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        phone: json["phone"],
        wapp: json["wapp"],
        geolocation: json["geolocation"],
        signature: json["signature"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "image": image,
        "phone": phone,
        "wapp": wapp,
        "geolocation": geolocation,
        "signature": signature,
        "time": time.toIso8601String(),
      };
}

List<LocationModel> locationModelFromJson(String str) =>
    List<LocationModel>.from(
        json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationModelToJson(List<LocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModel {
  LocationModel({
    required this.division,
    required this.city,
  });

  String division;
  String city;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        division: json["division"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "division": division,
        "city": city,
      };
}

//update location model

LocationUpdateModel locationUpdateModelFromJson(String str) =>
    LocationUpdateModel.fromJson(json.decode(str));

String locationUpdateModelToJson(LocationUpdateModel data) =>
    json.encode(data.toJson());

class LocationUpdateModel {
  LocationUpdateModel({
    required this.uid,
    required this.division,
    required this.city,
  });

  int uid;
  String division;
  String city;

  factory LocationUpdateModel.fromJson(Map<String, dynamic> json) =>
      LocationUpdateModel(
        uid: json["uid"],
        division: json["division"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "division": division,
        "city": city,
      };
}

// To parse this JSON data, do
//
//     final profileUpadte = profileUpadteFromJson(jsonString);

ProfileUpadte profileUpadteFromJson(String str) =>
    ProfileUpadte.fromJson(json.decode(str));

String profileUpadteToJson(ProfileUpadte data) => json.encode(data.toJson());

class ProfileUpadte {
  int uid;
  String name;
  String phone;
  String wapp;

  ProfileUpadte({
    required this.uid,
    required this.name,
    required this.phone,
    required this.wapp,
  });

  factory ProfileUpadte.fromJson(Map<String, dynamic> json) => ProfileUpadte(
        uid: json["uid"],
        name: json["name"],
        phone: json["phone"],
        wapp: json["wapp"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "phone": phone,
        "wapp": wapp,
      };
}
// To parse this JSON data, do
//
//     final notes = notesFromJson(jsonString);

Notes notesFromJson(String str) => Notes.fromJson(json.decode(str));

String notesToJson(Notes data) => json.encode(data.toJson());

class Notes {
  int nId;
  String text;
  int adminBy;
  DateTime time;
  int active;

  Notes({
    required this.nId,
    required this.text,
    required this.adminBy,
    required this.time,
    required this.active,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        nId: json["n_id"],
        text: json["text"],
        adminBy: json["admin_by"],
        time: DateTime.parse(json["time"]),
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "n_id": nId,
        "text": text,
        "admin_by": adminBy,
        "time": time.toIso8601String(),
        "active": active,
      };
}

// To parse this JSON data, do
//
//     final toletPostList = toletPostListFromJson(jsonString);

List<ToletPostList> toletPostListFromJson(String str) =>
    List<ToletPostList>.from(
        json.decode(str).map((x) => ToletPostList.fromJson(x)));

String toletPostListToJson(List<ToletPostList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToletPostList {
  final int postId;
  final int uid;
  final int bed;
  final int bath;
  final int roomsize;
  final int rent;
  final String image1;
  final String location;
  final DateTime time;

  ToletPostList({
    required this.postId,
    required this.uid,
    required this.bed,
    required this.bath,
    required this.roomsize,
    required this.rent,
    required this.image1,
    required this.location,
    required this.time,
  });

  factory ToletPostList.fromJson(Map<String, dynamic> json) => ToletPostList(
        postId: json["post_id"],
        uid: json["uid"],
        bed: json["bed"],
        bath: json["bath"],
        roomsize: json["roomsize"],
        rent: json["rent"],
        image1: json["image1"],
        location: json["location"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "uid": uid,
        "bed": bed,
        "bath": bath,
        "roomsize": roomsize,
        "rent": rent,
        "image1": image1,
        "location": location,
        "time": time.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final postToServerTolet = postToServerToletFromJson(jsonString);

PostToServerTolet postToServerToletFromJson(String str) =>
    PostToServerTolet.fromJson(json.decode(str));

String postToServerToletToJson(PostToServerTolet data) =>
    json.encode(data.toJson());

class PostToServerTolet {
  final int uid;
  final String propertyname;
  final String category;
  final String bed;
  final String bath;
  final String dining;
  final String kitchen;
  final String floornumber;
  final String facing;
  final String roomsize;
  final DateTime rentfrom;
  final int mentenance;
  final int rent;
  final String fasalitis;
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

  PostToServerTolet({
    required this.uid,
    required this.propertyname,
    required this.category,
    required this.bed,
    required this.bath,
    required this.dining,
    required this.kitchen,
    required this.floornumber,
    required this.facing,
    required this.roomsize,
    required this.rentfrom,
    required this.mentenance,
    required this.rent,
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
  });

  factory PostToServerTolet.fromJson(Map<String, dynamic> json) =>
      PostToServerTolet(
        uid: json["uid"],
        propertyname: json["propertyname"],
        category: json["category"],
        bed: json["bed"],
        bath: json["bath"],
        dining: json["dining"],
        kitchen: json["kitchen"],
        floornumber: json["floornumber"],
        facing: json["facing"],
        roomsize: json["roomsize"],
        rentfrom: DateTime.parse(json["rentfrom"]),
        mentenance: json["mentenance"],
        rent: json["rent"],
        fasalitis: json["fasalitis"],
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
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "propertyname": propertyname,
        "category": category,
        "bed": bed,
        "bath": bath,
        "dining": dining,
        "kitchen": kitchen,
        "floornumber": floornumber,
        "facing": facing,
        "roomsize": roomsize,
        "rentfrom": rentfrom.toIso8601String(),
        "mentenance": mentenance,
        "rent": rent,
        "fasalitis": fasalitis,
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
      };
}
// To parse this JSON data, do
//
//     final profileUpdate = profileUpdateFromJson(jsonString);

ProfileUpdate profileUpdateFromJson(String str) =>
    ProfileUpdate.fromJson(json.decode(str));

String profileUpdateToJson(ProfileUpdate data) => json.encode(data.toJson());

class ProfileUpdate {
  final int uid;
  final String name;
  final String phone;
  final String wapp;

  ProfileUpdate({
    required this.uid,
    required this.name,
    required this.phone,
    required this.wapp,
  });

  factory ProfileUpdate.fromJson(Map<String, dynamic> json) => ProfileUpdate(
        uid: json["uid"],
        name: json["name"],
        phone: json["phone"],
        wapp: json["wapp"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "phone": phone,
        "wapp": wapp,
      };
}
