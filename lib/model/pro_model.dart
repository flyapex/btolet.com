// To parse this JSON data, do
//
//     final postListPro = postListProFromJson(jsonString);

import 'dart:convert';

List<PostListPro> postListProFromJson(String str) => List<PostListPro>.from(
    json.decode(str).map((x) => PostListPro.fromJson(x)));

String postListProToJson(List<PostListPro> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostListPro {
  int pid;
  int uid;
  String category;
  int price;
  String procondition;
  String bed;
  String bath;
  String size;
  String image1;
  String location;
  String geolat;
  String geolon;
  String phone;
  String wapp;
  DateTime time;
  String area;
  String measurement;
  String image;
  double? distance;
  int totalImage;
  PostListPro({
    required this.pid,
    required this.uid,
    required this.category,
    required this.price,
    required this.procondition,
    required this.bed,
    required this.bath,
    required this.size,
    required this.image1,
    required this.location,
    required this.geolat,
    required this.geolon,
    required this.phone,
    required this.wapp,
    required this.time,
    required this.area,
    required this.measurement,
    required this.image,
    required this.distance,
    required this.totalImage,
  });

  factory PostListPro.fromJson(Map<String, dynamic> json) => PostListPro(
        pid: json["pid"],
        uid: json["uid"],
        category: json["category"],
        price: json["price"],
        procondition: json["procondition"],
        bed: json["bed"],
        bath: json["bath"],
        size: json["size"],
        image1: json["image1"],
        location: json["location"],
        geolat: json["geolat"],
        geolon: json["geolon"],
        phone: json["phone"],
        wapp: json["wapp"],
        time: DateTime.parse(json["time"]),
        area: json["area"],
        measurement: json["measurement"],
        image: json["image"],
        distance: json["distance"]?.toDouble(),
        totalImage: json["total_image"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "uid": uid,
        "category": category,
        "price": price,
        "procondition": procondition,
        "bed": bed,
        "bath": bath,
        "size": size,
        "image1": image1,
        "location": location,
        "geolat": geolat,
        "geolon": geolon,
        "phone": phone,
        "wapp": wapp,
        "time": time.toIso8601String(),
        "area": area,
        "measurement": measurement,
        "image": image,
        "distance": distance,
        "total_image": totalImage,
      };
}
// To parse this JSON data, do
//
//     final singlePostModelPro = singlePostModelProFromJson(jsonString);

SinglePostModelPro singlePostModelProFromJson(String str) =>
    SinglePostModelPro.fromJson(json.decode(str));

String singlePostModelProToJson(SinglePostModelPro data) =>
    json.encode(data.toJson());

class SinglePostModelPro {
  int pid;
  int uid;
  String category;
  String name;
  String procondition;
  String bed;
  String bath;
  String balcony;
  String drawing;
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
  String locationfull;
  String shortaddress;
  String description;
  String ownertype;
  String geolat;
  String geolon;
  String phone;
  String wapp;
  String landType;
  String area;
  String measurement;
  String roadSize;
  String emi;
  int status;
  int payment;
  int topAds;
  DateTime time;

  SinglePostModelPro({
    required this.pid,
    required this.uid,
    required this.category,
    required this.name,
    required this.procondition,
    required this.bed,
    required this.bath,
    required this.balcony,
    required this.drawing,
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
    required this.locationfull,
    required this.shortaddress,
    required this.description,
    required this.ownertype,
    required this.geolat,
    required this.geolon,
    required this.phone,
    required this.wapp,
    required this.landType,
    required this.area,
    required this.measurement,
    required this.roadSize,
    required this.emi,
    required this.status,
    required this.payment,
    required this.topAds,
    required this.time,
  });

  factory SinglePostModelPro.fromJson(Map<String, dynamic> json) =>
      SinglePostModelPro(
        pid: json["pid"],
        uid: json["uid"],
        category: json["category"],
        name: json["name"],
        procondition: json["procondition"],
        bed: json["bed"],
        bath: json["bath"],
        balcony: json["balcony"],
        drawing: json["drawing"],
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
        locationfull: json["locationfull"],
        shortaddress: json["shortaddress"],
        description: json["description"],
        ownertype: json["ownertype"],
        geolat: json["geolat"],
        geolon: json["geolon"],
        phone: json["phone"],
        wapp: json["wapp"],
        landType: json["land_type"],
        area: json["area"],
        measurement: json["measurement"],
        roadSize: json["road_size"],
        emi: json["emi"],
        status: json["status"],
        payment: json["payment"],
        topAds: json["top_ads"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "uid": uid,
        "category": category,
        "name": name,
        "procondition": procondition,
        "bed": bed,
        "bath": bath,
        "balcony": balcony,
        "drawing": drawing,
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
        "locationfull": locationfull,
        "shortaddress": shortaddress,
        "description": description,
        "ownertype": ownertype,
        "geolat": geolat,
        "geolon": geolon,
        "phone": phone,
        "wapp": wapp,
        "land_type": landType,
        "area": area,
        "measurement": measurement,
        "road_size": roadSize,
        "emi": emi,
        "status": status,
        "payment": payment,
        "top_ads": topAds,
        "time": time.toIso8601String(),
      };
}

NewPostPro newPostProFromJson(String str) =>
    NewPostPro.fromJson(json.decode(str));

String newPostProToJson(NewPostPro data) => json.encode(data.toJson());

class NewPostPro {
  int uid;
  String category;
  String name;
  String procondition;
  String bed;
  String bath;
  String balcony;
  String drawing;
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
  String locationfull;
  String shortaddress;
  String description;
  String ownertype;
  String geolon;
  String geolat;
  String phone;
  String wapp;
  String landType;
  String area;
  String measurement;
  String roadSize;
  String emi;

  NewPostPro({
    required this.uid,
    required this.category,
    required this.name,
    required this.procondition,
    required this.bed,
    required this.bath,
    required this.balcony,
    required this.drawing,
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
    required this.locationfull,
    required this.shortaddress,
    required this.description,
    required this.ownertype,
    required this.geolat,
    required this.geolon,
    required this.phone,
    required this.wapp,
    required this.landType,
    required this.area,
    required this.measurement,
    required this.roadSize,
    required this.emi,
  });

  factory NewPostPro.fromJson(Map<String, dynamic> json) => NewPostPro(
        uid: json["uid"],
        category: json["category"],
        name: json["name"],
        procondition: json["procondition"],
        bed: json["bed"],
        bath: json["bath"],
        balcony: json["balcony"],
        drawing: json["drawing"],
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
        locationfull: json["locationfull"],
        shortaddress: json["shortaddress"],
        description: json["description"],
        ownertype: json["ownertype"],
        geolat: json["geolat"],
        geolon: json["geolon"],
        phone: json["phone"],
        wapp: json["wapp"],
        landType: json["land_type"],
        area: json["area"],
        measurement: json["measurement"],
        roadSize: json["road_size"],
        emi: json["emi"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "category": category,
        "name": name,
        "procondition": procondition,
        "bed": bed,
        "bath": bath,
        "balcony": balcony,
        "drawing": drawing,
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
        "locationfull": locationfull,
        "shortaddress": shortaddress,
        "description": description,
        "ownertype": ownertype,
        "geolat": geolat,
        "geolon": geolon,
        "phone": phone,
        "wapp": wapp,
        "land_type": landType,
        "area": area,
        "measurement": measurement,
        "road_size": roadSize,
        "emi": emi,
      };
}

SortPostPro sortPostProFromJson(String str) =>
    SortPostPro.fromJson(json.decode(str));

String sortPostProToJson(SortPostPro data) => json.encode(data.toJson());

class SortPostPro {
  String geolat;
  String geolon;
  int page;
  String category;
  String fasalitis;
  int rentmin;
  int rentmax;
  String bed;
  String bath;

  SortPostPro({
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

  factory SortPostPro.fromJson(Map<String, dynamic> json) => SortPostPro(
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
//     final mapProModel = mapProModelFromJson(jsonString);

List<MapProModel> mapProModelFromJson(String str) => List<MapProModel>.from(
    json.decode(str).map((x) => MapProModel.fromJson(x)));

String mapProModelToJson(List<MapProModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MapProModel {
  final int pid;
  final String geolat;
  final String geolon;
  final int price;

  MapProModel({
    required this.pid,
    required this.geolat,
    required this.geolon,
    required this.price,
  });

  factory MapProModel.fromJson(Map<String, dynamic> json) => MapProModel(
        pid: json["pid"],
        geolat: json["geolat"],
        geolon: json["geolon"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "geolat": geolat,
        "geolon": geolon,
        "price": price,
      };
}
// To parse this JSON data, do
//
//     final mapProPostListModel = mapProPostListModelFromJson(jsonString);

List<MapProPostListModel> mapProPostListModelFromJson(String str) =>
    List<MapProPostListModel>.from(
        json.decode(str).map((x) => MapProPostListModel.fromJson(x)));

String mapProPostListModelToJson(List<MapProPostListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MapProPostListModel {
  final int pid;
  final int uid;
  final String bed;
  final String bath;
  final String category;
  final String kitchen;
  final String size;
  final int price;
  final String image1;
  final String area;
  final String measurement;
  final String location;
  final DateTime time;
  final double? distance;
  final int totalImage;
  MapProPostListModel({
    required this.pid,
    required this.uid,
    required this.bed,
    required this.bath,
    required this.category,
    required this.kitchen,
    required this.size,
    required this.price,
    required this.image1,
    required this.area,
    required this.measurement,
    required this.location,
    required this.time,
    required this.distance,
    required this.totalImage,
  });

  factory MapProPostListModel.fromJson(Map<String, dynamic> json) =>
      MapProPostListModel(
        pid: json["pid"],
        uid: json["uid"],
        bed: json["bed"],
        bath: json["bath"],
        category: json["category"],
        kitchen: json["kitchen"],
        size: json["size"],
        price: json["price"],
        image1: json["image1"],
        area: json["area"],
        measurement: json["measurement"],
        location: json["location"],
        time: DateTime.parse(json["time"]),
        distance: json["distance"]?.toDouble(),
        totalImage: json["total_image"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "uid": uid,
        "bed": bed,
        "bath": bath,
        "category": category,
        "kitchen": kitchen,
        "size": size,
        "price": price,
        "image1": image1,
        "area": area,
        "measurement": measurement,
        "location": location,
        "time": time.toIso8601String(),
        "distance": distance,
        "total_image": totalImage,
      };
}
