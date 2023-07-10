import 'device_list.dart';

class AuthDetailModel {
  AuthDetailModel({
    this.status,
    this.message,
    this.data,
    this.code,
    this.signature,
  });

  bool? status;
  String? message;
  AuthDetail? data;
  int? code;
  dynamic signature;

  factory AuthDetailModel.fromJson(Map<String, dynamic> json) =>
      AuthDetailModel(
        status: json["status"],
        message: json["message"],
        data: json["user"] == null ? null : AuthDetail.fromJson(json["user"]),
        code: int.parse(json["code"].toString()),
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": data?.toJson(),
        "code": code,
        "signature": signature,
      };
  AuthDetailModel.withError(this.message);
}

class AuthDetail {
  AuthDetail({
    this.name,
    this.email,
    this.phone_number,
    this.uuid,
    this.created,
  });

  String? name;
  String? email;
  String? phone_number;
  String? uuid;
  CreatedData? created;

  factory AuthDetail.fromJson(Map<String, dynamic> json) => AuthDetail(
        name : json['name'],
        email : json['email'],
        phone_number : json['phone_number'].toString(),
        uuid : json['uuid'].toString(),
        created : CreatedData.fromJson(json['created']),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
      };
}
