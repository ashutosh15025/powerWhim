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
  String? name;
  int? age;
  String? hobbies;
  String? sports;
  String? ambition;
  String? accomplishment;

  Data({
    this.name,
    this.age,
    this.hobbies,
    this.sports,
    this.ambition,
    this.accomplishment,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    age: json["age"],
    hobbies: json["hobbies"],
    sports: json["sports"],
    ambition: json["ambition"],
    accomplishment: json["accomplishment"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
    "hobbies": hobbies,
    "sports": sports,
    "ambition": ambition,
    "accomplishment": accomplishment,
  };
}
