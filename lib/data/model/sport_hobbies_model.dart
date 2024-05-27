// To parse this JSON data, do
//
//     final sportHobbiesModel = sportHobbiesModelFromJson(jsonString);

import 'dart:convert';

SportHobbiesModel sportHobbiesModelFromJson(String str) => SportHobbiesModel.fromJson(json.decode(str));

String sportHobbiesModelToJson(SportHobbiesModel data) => json.encode(data.toJson());

class SportHobbiesModel {
  Data? data;

  SportHobbiesModel({
    this.data,
  });

  factory SportHobbiesModel.fromJson(Map<String, dynamic> json) => SportHobbiesModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? mssg;
  String? status;
  List<String>? list;

  Data({
    this.mssg,
    this.status,
    this.list,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mssg: json["mssg"],
    status: json["status"],
    list: json["list"] == null ? [] : List<String>.from(json["list"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "mssg": mssg,
    "status": status,
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x)),
  };
}
