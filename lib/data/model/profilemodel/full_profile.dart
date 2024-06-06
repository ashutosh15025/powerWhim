// To parse this JSON data, do
//
//     final fullProfileModel = fullProfileModelFromJson(jsonString);

import 'dart:convert';

FullProfileModel fullProfileModelFromJson(String str) => FullProfileModel.fromJson(json.decode(str));

String fullProfileModelToJson(FullProfileModel data) => json.encode(data.toJson());

class FullProfileModel {
  Data? data;

  FullProfileModel({
    this.data,
  });

  factory FullProfileModel.fromJson(Map<String, dynamic> json) => FullProfileModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? status;
  String? mssg;
  Profile? profile;
  bool? visibility;

  Data({
    this.status,
    this.mssg,
    this.profile,
    this.visibility,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    mssg: json["mssg"],
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    visibility: json["visibility"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "mssg": mssg,
    "profile": profile?.toJson(),
    "visibility": visibility,
  };
}

class Profile {
  String? name;
  int? age;
  dynamic hobbies;
  String? sports;
  String? ambition;
  String? accomplishment;
  List<String>? photos;
  String? userId;

  Profile({
    this.name,
    this.age,
    this.hobbies,
    this.sports,
    this.ambition,
    this.accomplishment,
    this.photos,
    this.userId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json["name"],
    age: json["age"],
    hobbies: json["hobbies"],
    sports: json["sports"],
    ambition: json["ambition"],
    accomplishment: json["accomplishment"],
    photos: json["photos"] == null ? [] : List<String>.from(json["photos"]!.map((x) => x)),
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
    "hobbies": hobbies,
    "sports": sports,
    "ambition": ambition,
    "accomplishment": accomplishment,
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
    "user_id": userId,
  };
}
