import 'auth_detail.dart';

class ArticlesListModel {
  ArticlesListModel({
    this.status,
    this.message,
    this.data,
    this.code,
    this.signature,
  });

  bool? status;
  String? message;
  List<Articles>? data;
  int? code;
  dynamic signature;

  factory ArticlesListModel.fromJson(Map<String, dynamic> json) =>
      ArticlesListModel(
        status: json["status"],
        message: json["message"],
        data: json["articles"] == null
            ? null
            : List<Articles>.from(
                json["articles"].map((x) => Articles.fromJson(x))),
        code: json["code"],
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "articles": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
        "signature": signature,
      };

  ArticlesListModel.withError(this.message);
}

class Articles {
  Articles({
    this.uuid,
    this.title,
    this.content,
    this.image,
    this.views,
    this.crated,
    this.user,
  });

  String? uuid;
  String? title;
  String? content;
  String? image;
  int? views;
  CreatedData? crated;
  AuthDetail? user;

  factory Articles.fromJson(Map<String, dynamic> json) => Articles(
        uuid: json["uuid"] == null ? null : json["uuid"].toString(),
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
        views: json["views"] == null ? 0 : int.parse(json["views"].toString()),
        image: json["image"] == null ? null : json["image"],
        crated: json["crated"] == null
            ? null
            : CreatedData.fromJson(json["crated"]),
        user:
            json["user"] == null ? null : AuthDetail.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
      };
}

class CreatedData {
  CreatedData({
    this.timeZoneType,
    this.timeZone,
    this.date,
  });

  int? timeZoneType;
  String? timeZone;
  DateTime? date;

  factory CreatedData.fromJson(Map<String, dynamic> json) => CreatedData(
        timeZoneType: json["timezone_type"] == null
            ? 0
            : int.parse(json["timezone_type"].toString()),
        timeZone:
            json["timezone"] == null ? null : (json["timezone"].toString()),
        date: json["date"] == null
            ? null
            : DateTime.parse(json["date"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
      };
}
