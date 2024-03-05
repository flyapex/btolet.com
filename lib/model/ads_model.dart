import 'dart:convert';

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
