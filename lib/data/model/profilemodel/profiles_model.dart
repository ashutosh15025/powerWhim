// To parse this JSON data, do
//
//     final profilesModel = profilesModelFromJson(jsonString);

import 'dart:convert';

ProfilesModel profilesModelFromJson(String str) => ProfilesModel.fromJson(json.decode(str));

String profilesModelToJson(ProfilesModel data) => json.encode(data.toJson());

class ProfilesModel {
  Data? data;

  ProfilesModel({
    this.data,
  });

  factory ProfilesModel.fromJson(Map<String, dynamic> json) => ProfilesModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? status;
  String? mssg;
  List<Profile>? profiles;

  Data({
    this.status,
    this.mssg,
    this.profiles,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    mssg: json["mssg"],
    profiles: json["profiles"] == null ? [] : List<Profile>.from(json["profiles"]!.map((x) => Profile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "mssg": mssg,
    "profiles": profiles == null ? [] : List<dynamic>.from(profiles!.map((x) => x.toJson())),
  };
}

class Profile {
  String? name;
  dynamic sports;
  dynamic hobbies;
  String? userId;
  int? age;

  Profile({
    this.name,
    this.sports,
    this.hobbies,
    this.userId,
    this.age,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json["name"],
    sports: json["sports"],
    hobbies: json["hobbies"],
    userId: json["user_id"],
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "sports": sports,
    "hobbies": hobbies,
    "user_id": userId,
    "age": age,
  };
}
