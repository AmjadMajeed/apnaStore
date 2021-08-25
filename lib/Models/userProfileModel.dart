
import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    required this.profile,
  });

  List<Profile> profile;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    profile: List<Profile>.from(json["profile"].map((x) => Profile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "profile": List<dynamic>.from(profile.map((x) => x.toJson())),
  };
}

class Profile {
  Profile({
    this.userCode,
    required this.phone,
    required this.address,
    required this.status,
    required this.id,
    required this.user,
    required this.fullName,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  dynamic userCode;
  int phone;
  String address;
  String status;
  String id;
  String user;
  String fullName;
  String email;
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
    fullName: json["fullName"],
    email: json["email"],
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
    "fullName": fullName,
    "email": email,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
