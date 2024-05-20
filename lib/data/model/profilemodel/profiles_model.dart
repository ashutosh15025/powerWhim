// To parse this JSON data, do
//
//     final profilesModel = profilesModelFromJson(jsonString);

import 'dart:convert';

ProfilesModel profilesModelFromJson(String str) => ProfilesModel.fromJson(json.decode(str));

String profilesModelToJson(ProfilesModel data) => json.encode(data.toJson());

class ProfilesModel {
  List<SingleProfile>? data;

  ProfilesModel({
    this.data,
  });

  factory ProfilesModel.fromJson(Map<String, dynamic> json) => ProfilesModel(
    data: json["data"] == null ? [] : List<SingleProfile>.from(json["data"]!.map((x) => SingleProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleProfile {
  String? name;
  String? sports;
  String? hobbies;
  String? userId;
  int? age;

  SingleProfile({
    this.name,
    this.sports,
    this.hobbies,
    this.userId,
    this.age,
  });

  factory SingleProfile.fromJson(Map<String, dynamic> json) => SingleProfile(
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
