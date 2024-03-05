import 'dart:convert';

// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(
    json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
  final int placeId;
  final String licence;
  final String osmType;
  final int osmId;
  final List<String> boundingbox;
  final String lat;
  final String lon;
  final String displayName;
  final int placeRank;
  final String category;
  final String type;
  final double importance;

  SearchModel({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.boundingbox,
    required this.lat,
    required this.lon,
    required this.displayName,
    required this.placeRank,
    required this.category,
    required this.type,
    required this.importance,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        placeId: json["place_id"],
        licence: json["licence"],
        osmType: json["osm_type"],
        osmId: json["osm_id"],
        boundingbox: List<String>.from(json["boundingbox"].map((x) => x)),
        lat: json["lat"],
        lon: json["lon"],
        displayName: json["display_name"],
        placeRank: json["place_rank"],
        category: json["category"],
        type: json["type"],
        importance: json["importance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "licence": licence,
        "osm_type": osmType,
        "osm_id": osmId,
        "boundingbox": List<dynamic>.from(boundingbox.map((x) => x)),
        "lat": lat,
        "lon": lon,
        "display_name": displayName,
        "place_rank": placeRank,
        "category": category,
        "type": type,
        "importance": importance,
      };
}

// To parse this JSON data, do
//
//     final mapSuggstionModel = mapSuggstionModelFromJson(jsonString);

List<MapSuggstionModel> mapSuggstionModelFromJson(String str) =>
    List<MapSuggstionModel>.from(
        json.decode(str).map((x) => MapSuggstionModel.fromJson(x)));

String mapSuggstionModelToJson(List<MapSuggstionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MapSuggstionModel {
  int? placeId;
  String? licence;
  String? osmType;
  int? osmId;
  List<String>? boundingbox;
  String? lat;
  String? lon;
  String? displayName;
  int? placeRank;
  String? category;
  String? type;
  double? importance;
  String? icon;

  MapSuggstionModel({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.boundingbox,
    this.lat,
    this.lon,
    this.displayName,
    this.placeRank,
    this.category,
    this.type,
    this.importance,
    this.icon,
  });

  factory MapSuggstionModel.fromJson(Map<String, dynamic> json) =>
      MapSuggstionModel(
        placeId: json["place_id"],
        licence: json["licence"],
        osmType: json["osm_type"],
        osmId: json["osm_id"],
        boundingbox: json["boundingbox"] == null
            ? []
            : List<String>.from(json["boundingbox"]!.map((x) => x)),
        lat: json["lat"],
        lon: json["lon"],
        displayName: json["display_name"],
        placeRank: json["place_rank"],
        category: json["category"],
        type: json["type"],
        importance: json["importance"]?.toDouble(),
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "licence": licence,
        "osm_type": osmType,
        "osm_id": osmId,
        "boundingbox": boundingbox == null
            ? []
            : List<dynamic>.from(boundingbox!.map((x) => x)),
        "lat": lat,
        "lon": lon,
        "display_name": displayName,
        "place_rank": placeRank,
        "category": category,
        "type": type,
        "importance": importance,
        "icon": icon,
      };
}

CoordinateToAddressModel coordinateToAddressModelFromJson(String str) =>
    CoordinateToAddressModel.fromJson(json.decode(str));

String coordinateToAddressModelToJson(CoordinateToAddressModel data) =>
    json.encode(data.toJson());

class CoordinateToAddressModel {
  int? placeId;
  String? licence;
  String? osmType;
  int? osmId;
  String? lat;
  String? lon;
  int? placeRank;
  String? category;
  String? type;
  double? importance;
  String? addresstype;
  dynamic name;
  String? displayName;
  Address? address;
  List<String>? boundingbox;

  CoordinateToAddressModel({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.placeRank,
    this.category,
    this.type,
    this.importance,
    this.addresstype,
    this.name,
    this.displayName,
    this.address,
    this.boundingbox,
  });

  factory CoordinateToAddressModel.fromJson(Map<String, dynamic> json) =>
      CoordinateToAddressModel(
        placeId: json["place_id"],
        licence: json["licence"],
        osmType: json["osm_type"],
        osmId: json["osm_id"],
        lat: json["lat"],
        lon: json["lon"],
        placeRank: json["place_rank"],
        category: json["category"],
        type: json["type"],
        importance: json["importance"]?.toDouble(),
        addresstype: json["addresstype"],
        name: json["name"],
        displayName: json["display_name"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        boundingbox: json["boundingbox"] == null
            ? []
            : List<String>.from(json["boundingbox"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "licence": licence,
        "osm_type": osmType,
        "osm_id": osmId,
        "lat": lat,
        "lon": lon,
        "place_rank": placeRank,
        "category": category,
        "type": type,
        "importance": importance,
        "addresstype": addresstype,
        "name": name,
        "display_name": displayName,
        "address": address?.toJson(),
        "boundingbox": boundingbox == null
            ? []
            : List<dynamic>.from(boundingbox!.map((x) => x)),
      };
}

class Address {
  String? city;
  String? county;
  String? stateDistrict;
  String? state;
  String? iso31662Lvl4;
  String? postcode;
  String? country;
  String? countryCode;

  Address({
    this.city,
    this.county,
    this.stateDistrict,
    this.state,
    this.iso31662Lvl4,
    this.postcode,
    this.country,
    this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        county: json["county"],
        stateDistrict: json["state_district"],
        state: json["state"],
        iso31662Lvl4: json["ISO3166-2-lvl4"],
        postcode: json["postcode"],
        country: json["country"],
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "county": county,
        "state_district": stateDistrict,
        "state": state,
        "ISO3166-2-lvl4": iso31662Lvl4,
        "postcode": postcode,
        "country": country,
        "country_code": countryCode,
      };
}
