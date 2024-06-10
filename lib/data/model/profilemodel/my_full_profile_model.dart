// To parse this JSON data, do
//
//     final myFullProfileModel = myFullProfileModelFromJson(jsonString);

import 'dart:convert';

MyFullProfileModel myFullProfileModelFromJson(String str) => MyFullProfileModel.fromJson(json.decode(str));

String myFullProfileModelToJson(MyFullProfileModel data) => json.encode(data.toJson());

class MyFullProfileModel {
  Data? data;

  MyFullProfileModel({
    this.data,
  });

  factory MyFullProfileModel.fromJson(Map<String, dynamic> json) => MyFullProfileModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? status;
  String? mssg;
  MyProfile? myProfile;

  Data({
    this.status,
    this.mssg,
    this.myProfile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    mssg: json["mssg"],
    myProfile: json["myProfile"] == null ? null : MyProfile.fromJson(json["myProfile"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "mssg": mssg,
    "myProfile": myProfile?.toJson(),
  };
}

class MyProfile {
  String? profileId;
  String? name;
  DateTime? dateOfBirth;
  String? meetingDistance;
  String? sports;
  String? hobbies;
  dynamic ambition;
  dynamic accomplishment;
  List<bool>? weekAvailability;
  AgeRange? ageRange;
  List<String>? photos;

  MyProfile({
    this.profileId,
    this.name,
    this.dateOfBirth,
    this.meetingDistance,
    this.sports,
    this.hobbies,
    this.ambition,
    this.accomplishment,
    this.weekAvailability,
    this.ageRange,
    this.photos,
  });

  factory MyProfile.fromJson(Map<String, dynamic> json) => MyProfile(
    profileId: json["profile_id"],
    name: json["name"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    meetingDistance: json["meeting_distance"],
    sports: json["sports"],
    hobbies: json["hobbies"],
    ambition: json["ambition"],
    accomplishment: json["accomplishment"],
    weekAvailability: json["week_availability"] == null ? [] : List<bool>.from(json["week_availability"]!.map((x) => x)),
    ageRange: json["age_range"] == null ? null : AgeRange.fromJson(json["age_range"]),
    photos: json["photos"] == null ? [] : List<String>.from(json["photos"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "profile_id": profileId,
    "name": name,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "meeting_distance": meetingDistance,
    "sports": sports,
    "hobbies": hobbies,
    "ambition": ambition,
    "accomplishment": accomplishment,
    "week_availability": weekAvailability == null ? [] : List<dynamic>.from(weekAvailability!.map((x) => x)),
    "age_range": ageRange?.toJson(),
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
  };
}

class AgeRange {
  String? end;
  String? start;

  AgeRange({
    this.end,
    this.start,
  });

  factory AgeRange.fromJson(Map<String, dynamic> json) => AgeRange(
    end: json["end"],
    start: json["start"],
  );

  Map<String, dynamic> toJson() => {
    "end": end,
    "start": start,
  };
}
