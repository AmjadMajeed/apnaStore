// To parse this JSON data, do
//
//     final signUpUserModel = signUpUserModelFromJson(jsonString);

import 'dart:convert';

SignUpUserModel signUpUserModelFromJson(String str) => SignUpUserModel.fromJson(json.decode(str));

String signUpUserModelToJson(SignUpUserModel data) => json.encode(data.toJson());

class SignUpUserModel {
  SignUpUserModel({
    required this.msg,
    required this.profile,
  });

  String msg;
  Profile profile;

  factory SignUpUserModel.fromJson(Map<String, dynamic> json) => SignUpUserModel(
    msg: json["msg"],
    profile: Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "profile": profile.toJson(),
  };
}

class Profile {
  Profile({
    this.userCode,
    this.phone,
    this.address,
    required this.status,
    required this.id,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  dynamic userCode;
  dynamic phone;
  dynamic address;
  String status;
  String id;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    userCode: json["userCode"],
    phone: json["phone"],
    address: json["address"],
    status: json["status"],
    id: json["_id"],
    user: json["user"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userCode": userCode,
    "phone": phone,
    "address": address,
    "status": status,
    "_id": id,
    "user": user,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
