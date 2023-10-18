// To parse this JSON data, do
//
//     final bannerListModel = bannerListModelFromJson(jsonString);

import 'dart:convert';

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

UserDetails userDetailsFromJson(String str) =>
    UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

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
