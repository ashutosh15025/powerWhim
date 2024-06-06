import 'dart:convert';

AddProfileModel addProfileModelFromJson(String str) => AddProfileModel.fromJson(json.decode(str));

String addProfileModelToJson(AddProfileModel data) => json.encode(data.toJson());

class AddProfileModel {
  String? name;
  String? dateOfBirth;
  Age? age;
  List<String>? weekAvailability;
  String? meetingDistance;
  String? sports;
  String? hobbies;
  String? ambition;
  String? accomplishment;
  String? userId;
  List<String>? profileImage;

  AddProfileModel({
    this.name,
    this.dateOfBirth,
    this.age,
    this.weekAvailability,
    this.meetingDistance,
    this.sports,
    this.hobbies,
    this.ambition,
    this.accomplishment,
    this.userId,
    this.profileImage,
  });

  factory AddProfileModel.fromJson(Map<String, dynamic> json) => AddProfileModel(
    name: json["name"],
    dateOfBirth: json["date_of_birth"],
    age: json["age"] == null ? null : Age.fromJson(json["age"]),
    weekAvailability: json["week_availability"] == null ? [] : List<String>.from(json["week_availability"]!.map((x) => x)),
    meetingDistance: json["meeting_distance"],
    sports: json["sports"],
    hobbies: json["hobbies "],
    ambition: json["ambition"],
    accomplishment: json["accomplishment"],
    userId: json["user_id"],
    profileImage: json["profile_image"] == null ? [] : List<String>.from(json["profile_image"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "date_of_birth": dateOfBirth,
    "age": age?.toJson(),
    "week_availability": weekAvailability == null ? [] : List<dynamic>.from(weekAvailability!.map((x) => x)),
    "meeting_distance": meetingDistance,
    "sports": sports,
    "hobbies ": hobbies,
    "ambition": ambition,
    "accomplishment": accomplishment,
    "user_id": userId,
    "profile_image": profileImage == null ? [] : List<dynamic>.from(profileImage!.map((x) => x)),
  };
}

class Age {
  String? start;
  String? end;

  Age({
    this.start,
    this.end,
  });

  factory Age.fromJson(Map<String, dynamic> json) => Age(
    start: json["start"],
    end: json["end"],
  );

  Map<String, dynamic> toJson() => {
    "start": start,
    "end": end,
  };
}
