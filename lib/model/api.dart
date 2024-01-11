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
  int bId;
  int uid;
  String image;
  String url;
  String number;
  int durationDay;
  int amount;
  DateTime postTime;
  int status;

  BannerListModel({
    required this.bId,
    required this.uid,
    required this.image,
    required this.url,
    required this.number,
    required this.durationDay,
    required this.amount,
    required this.postTime,
    required this.status,
  });

  factory BannerListModel.fromJson(Map<String, dynamic> json) =>
      BannerListModel(
        bId: json["b_id"],
        uid: json["uid"],
        image: json["image"],
        url: json["url"],
        number: json["number"],
        durationDay: json["duration_day"],
        amount: json["amount"],
        postTime: DateTime.parse(json["post_time"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "b_id": bId,
        "uid": uid,
        "image": image,
        "url": url,
        "number": number,
        "duration_day": durationDay,
        "amount": amount,
        "post_time": postTime.toIso8601String(),
        "status": status,
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
  int status;

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
    required this.status,
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
        status: json["status"],
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
        "status": status,
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

// class UserUpdate {
//   final int uid;
//   final String name;
//   final String phone;

//   UserUpdate({
//     required this.uid,
//     required this.name,
//     required this.phone,
//   });

//   factory UserUpdate.fromRawJson(String str) =>
//       UserUpdate.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory UserUpdate.fromJson(Map<String, dynamic> json) => UserUpdate(
//         uid: json["uid"],
//         name: json["name"],
//         phone: json["phone"],
//       );

//   Map<String, dynamic> toJson() => {
//         "uid": uid,
//         "name": name,
//         "phone": phone,
//       };
// }

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
  final String garagetype;
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
        garagetype: json["garagetype"],
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
        "garagetype": garagetype,
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
//     final toletSinglePost = toletSinglePostFromJson(jsonString);

// To parse this JSON data, do
//
//     final mapTolet = mapToletFromJson(jsonString);

List<MapTolet> mapToletFromJson(String str) =>
    List<MapTolet>.from(json.decode(str).map((x) => MapTolet.fromJson(x)));

String mapToletToJson(List<MapTolet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MapTolet {
  int postId;
  String geolon;
  String geolat;
  int rent;

  MapTolet({
    required this.postId,
    required this.geolon,
    required this.geolat,
    required this.rent,
  });

  factory MapTolet.fromJson(Map<String, dynamic> json) => MapTolet(
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
// To parse this JSON data, do
//
//     final mapPostTolet = mapPostToletFromJson(jsonString);

List<MapPostTolet> mapPostToletFromJson(String str) => List<MapPostTolet>.from(
    json.decode(str).map((x) => MapPostTolet.fromJson(x)));

String mapPostToletToJson(List<MapPostTolet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MapPostTolet {
  int postId;
  int uid;
  String bed;
  String bath;
  String roomsize;
  String kitchen;
  int rent;
  String image1;
  String location;
  DateTime time;
  String geolon;
  String geolat;
  double distance;

  MapPostTolet({
    required this.postId,
    required this.uid,
    required this.bed,
    required this.bath,
    required this.roomsize,
    required this.kitchen,
    required this.rent,
    required this.image1,
    required this.location,
    required this.time,
    required this.geolon,
    required this.geolat,
    required this.distance,
  });

  factory MapPostTolet.fromJson(Map<String, dynamic> json) => MapPostTolet(
        postId: json["post_id"],
        uid: json["uid"],
        bed: json["bed"],
        bath: json["bath"],
        roomsize: json["roomsize"],
        kitchen: json["kitchen"],
        rent: json["rent"],
        image1: json["image1"],
        location: json["location"],
        time: DateTime.parse(json["time"]),
        geolon: json["geolon"],
        geolat: json["geolat"],
        distance: json["distance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "uid": uid,
        "bed": bed,
        "bath": bath,
        "roomsize": roomsize,
        "kitchen": kitchen,
        "rent": rent,
        "image1": image1,
        "location": location,
        "time": time.toIso8601String(),
        "geolon": geolon,
        "geolat": geolat,
        "distance": distance,
      };
}

SortingPost sortingPostFromJson(String str) =>
    SortingPost.fromJson(json.decode(str));

String sortingPostToJson(SortingPost data) => json.encode(data.toJson());

class SortingPost {
  String geolat;
  String geolon;
  int page;
  String category;
  String fasalitis;
  int rentmin;
  int rentmax;
  String bed;
  String bath;

  SortingPost({
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

  factory SortingPost.fromJson(Map<String, dynamic> json) => SortingPost(
        geolat: json["geolat"],
        geolon: json["geolon"],
        page: json["page"],
        category: json["category"],
        fasalitis: json["fasalitis"],
        rentmin: json["rentmin"],
        rentmax: json["rentmax"],
        bed: json["bed"],
        bath: json["bath"],
      );

  Map<String, dynamic> toJson() => {
        "geolat": geolat,
        "geolon": geolon,
        "page": page,
        "category": category,
        "fasalitis": fasalitis,
        "rentmin": rentmin,
        "rentmax": rentmax,
        "bed": bed,
        "bath": bath,
      };
}
// To parse this JSON data, do
//
//     final newPostProperty = newPostPropertyFromJson(jsonString);

NewPostProperty newPostPropertyFromJson(String str) =>
    NewPostProperty.fromJson(json.decode(str));

String newPostPropertyToJson(NewPostProperty data) =>
    json.encode(data.toJson());

class NewPostProperty {
  int uid;
  int propertyType;
  String category;
  String propertyname;
  String propertycondition;
  String bed;
  String bath;
  String dining;
  String kitchen;
  String size;
  DateTime sellfrom;
  String totalFloor;
  String floornumber;
  String facing;
  String totalUnit;
  int price;
  String amenities;
  String floorPlan;
  String ytVideo;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String image6;
  String image7;
  String image8;
  String image9;
  String image10;
  String image11;
  String image12;
  String location;
  String shortaddress;
  String description;
  String ownertype;
  String geolon;
  String geolat;
  String phone;
  String wapp;
  String landType;
  String area;
  String measurementProperty;
  String roadSize;

  NewPostProperty({
    required this.uid,
    required this.propertyType,
    required this.category,
    required this.propertyname,
    required this.propertycondition,
    required this.bed,
    required this.bath,
    required this.dining,
    required this.kitchen,
    required this.size,
    required this.sellfrom,
    required this.totalFloor,
    required this.floornumber,
    required this.facing,
    required this.totalUnit,
    required this.price,
    required this.amenities,
    required this.floorPlan,
    required this.ytVideo,
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
    required this.location,
    required this.shortaddress,
    required this.description,
    required this.ownertype,
    required this.geolon,
    required this.geolat,
    required this.phone,
    required this.wapp,
    required this.landType,
    required this.area,
    required this.measurementProperty,
    required this.roadSize,
  });

  factory NewPostProperty.fromJson(Map<String, dynamic> json) =>
      NewPostProperty(
        uid: json["uid"],
        propertyType: json["propertyType"],
        category: json["category"],
        propertyname: json["propertyname"],
        propertycondition: json["propertycondition"],
        bed: json["bed"],
        bath: json["bath"],
        dining: json["dining"],
        kitchen: json["kitchen"],
        size: json["size"],
        sellfrom: DateTime.parse(json["sellfrom"]),
        totalFloor: json["total_floor"],
        floornumber: json["floornumber"],
        facing: json["facing"],
        totalUnit: json["total_unit"],
        price: json["price"],
        amenities: json["amenities"],
        floorPlan: json["floor_plan"],
        ytVideo: json["yt_video"],
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
        location: json["location"],
        shortaddress: json["shortaddress"],
        description: json["description"],
        ownertype: json["ownertype"],
        geolon: json["geolon"],
        geolat: json["geolat"],
        phone: json["phone"],
        wapp: json["wapp"],
        landType: json["land_type"],
        area: json["area"],
        measurementProperty: json["measurement_property"],
        roadSize: json["road_size"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "propertyType": propertyType,
        "category": category,
        "propertyname": propertyname,
        "propertycondition": propertycondition,
        "bed": bed,
        "bath": bath,
        "dining": dining,
        "kitchen": kitchen,
        "size": size,
        "sellfrom": sellfrom.toIso8601String(),
        "total_floor": totalFloor,
        "floornumber": floornumber,
        "facing": facing,
        "total_unit": totalUnit,
        "price": price,
        "amenities": amenities,
        "floor_plan": floorPlan,
        "yt_video": ytVideo,
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
        "location": location,
        "shortaddress": shortaddress,
        "description": description,
        "ownertype": ownertype,
        "geolon": geolon,
        "geolat": geolat,
        "phone": phone,
        "wapp": wapp,
        "land_type": landType,
        "area": area,
        "measurement_property": measurementProperty,
        "road_size": roadSize,
      };
}
// To parse this JSON data, do
//
//     final propertyList = propertyListFromJson(jsonString);

List<PropertyList> propertyListFromJson(String str) => List<PropertyList>.from(
    json.decode(str).map((x) => PropertyList.fromJson(x)));

String propertyListToJson(List<PropertyList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertyList {
  int pid;
  int uid;
  int propertyType;
  String category;
  int price;
  String propertycondition;
  String bed;
  String bath;
  String size;
  String image1;
  String location;
  String geolon;
  String geolat;
  String phone;
  String wapp;
  DateTime time;
  String area;
  String measurementProperty;
  String image;
  int distance;

  PropertyList({
    required this.pid,
    required this.uid,
    required this.propertyType,
    required this.category,
    required this.price,
    required this.propertycondition,
    required this.bed,
    required this.bath,
    required this.size,
    required this.image1,
    required this.location,
    required this.geolon,
    required this.geolat,
    required this.phone,
    required this.wapp,
    required this.time,
    required this.area,
    required this.measurementProperty,
    required this.image,
    required this.distance,
  });

  factory PropertyList.fromJson(Map<String, dynamic> json) => PropertyList(
        pid: json["pid"],
        uid: json["uid"],
        propertyType: json["propertyType"],
        category: json["category"],
        price: json["price"],
        propertycondition: json["propertycondition"],
        bed: json["bed"],
        bath: json["bath"],
        size: json["size"],
        image1: json["image1"],
        location: json["location"],
        geolon: json["geolon"],
        geolat: json["geolat"],
        phone: json["phone"],
        wapp: json["wapp"],
        time: DateTime.parse(json["time"]),
        area: json["area"],
        measurementProperty: json["measurement_property"],
        image: json["image"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "uid": uid,
        "propertyType": propertyType,
        "category": category,
        "price": price,
        "propertycondition": propertycondition,
        "bed": bed,
        "bath": bath,
        "size": size,
        "image1": image1,
        "location": location,
        "geolon": geolon,
        "geolat": geolat,
        "phone": phone,
        "wapp": wapp,
        "time": time.toIso8601String(),
        "area": area,
        "measurement_property": measurementProperty,
        "image": image,
        "distance": distance,
      };
}
// To parse this JSON data, do
//
//     final propertySinglePost = propertySinglePostFromJson(jsonString);

PropertySinglePost propertySinglePostFromJson(String str) =>
    PropertySinglePost.fromJson(json.decode(str));

String propertySinglePostToJson(PropertySinglePost data) =>
    json.encode(data.toJson());

class PropertySinglePost {
  int pid;
  int uid;
  int propertyType;
  String category;
  String propertyname;
  String propertycondition;
  String bed;
  String bath;
  String dining;
  String kitchen;
  String size;
  DateTime sellfrom;
  String totalFloor;
  String floornumber;
  String facing;
  String totalUnit;
  int price;
  String amenities;
  String floorPlan;
  String ytVideo;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String image6;
  String image7;
  String image8;
  String image9;
  String image10;
  String image11;
  String image12;
  String location;
  String shortaddress;
  String description;
  String ownertype;
  String geolon;
  String geolat;
  String phone;
  String wapp;
  String landType;
  String area;
  String measurementProperty;
  String roadSize;
  int click;
  int payment;
  int topAds;
  DateTime time;

  PropertySinglePost({
    required this.pid,
    required this.uid,
    required this.propertyType,
    required this.category,
    required this.propertyname,
    required this.propertycondition,
    required this.bed,
    required this.bath,
    required this.dining,
    required this.kitchen,
    required this.size,
    required this.sellfrom,
    required this.totalFloor,
    required this.floornumber,
    required this.facing,
    required this.totalUnit,
    required this.price,
    required this.amenities,
    required this.floorPlan,
    required this.ytVideo,
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
    required this.location,
    required this.shortaddress,
    required this.description,
    required this.ownertype,
    required this.geolon,
    required this.geolat,
    required this.phone,
    required this.wapp,
    required this.landType,
    required this.area,
    required this.measurementProperty,
    required this.roadSize,
    required this.click,
    required this.payment,
    required this.topAds,
    required this.time,
  });

  factory PropertySinglePost.fromJson(Map<String, dynamic> json) =>
      PropertySinglePost(
        pid: json["pid"],
        uid: json["uid"],
        propertyType: json["propertyType"],
        category: json["category"],
        propertyname: json["propertyname"],
        propertycondition: json["propertycondition"],
        bed: json["bed"],
        bath: json["bath"],
        dining: json["dining"],
        kitchen: json["kitchen"],
        size: json["size"],
        sellfrom: DateTime.parse(json["sellfrom"]),
        totalFloor: json["total_floor"],
        floornumber: json["floornumber"],
        facing: json["facing"],
        totalUnit: json["total_unit"],
        price: json["price"],
        amenities: json["amenities"],
        floorPlan: json["floor_plan"],
        ytVideo: json["yt_video"],
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
        location: json["location"],
        shortaddress: json["shortaddress"],
        description: json["description"],
        ownertype: json["ownertype"],
        geolon: json["geolon"],
        geolat: json["geolat"],
        phone: json["phone"],
        wapp: json["wapp"],
        landType: json["land_type"],
        area: json["area"],
        measurementProperty: json["measurement_property"],
        roadSize: json["road_size"],
        click: json["click"],
        payment: json["payment"],
        topAds: json["top_ads"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "uid": uid,
        "propertyType": propertyType,
        "category": category,
        "propertyname": propertyname,
        "propertycondition": propertycondition,
        "bed": bed,
        "bath": bath,
        "dining": dining,
        "kitchen": kitchen,
        "size": size,
        "sellfrom": sellfrom.toIso8601String(),
        "total_floor": totalFloor,
        "floornumber": floornumber,
        "facing": facing,
        "total_unit": totalUnit,
        "price": price,
        "amenities": amenities,
        "floor_plan": floorPlan,
        "yt_video": ytVideo,
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
        "location": location,
        "shortaddress": shortaddress,
        "description": description,
        "ownertype": ownertype,
        "geolon": geolon,
        "geolat": geolat,
        "phone": phone,
        "wapp": wapp,
        "land_type": landType,
        "area": area,
        "measurement_property": measurementProperty,
        "road_size": roadSize,
        "click": click,
        "payment": payment,
        "top_ads": topAds,
        "time": time.toIso8601String(),
      };
}

PostCount postCountFromJson(String str) => PostCount.fromJson(json.decode(str));

String postCountToJson(PostCount data) => json.encode(data.toJson());

class PostCount {
  final int postCount;

  PostCount({
    required this.postCount,
  });

  factory PostCount.fromJson(Map<String, dynamic> json) => PostCount(
        postCount: json["postCount"],
      );

  Map<String, dynamic> toJson() => {
        "postCount": postCount,
      };
}
