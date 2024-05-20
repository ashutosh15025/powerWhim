import 'dart:convert';

FriendsModel FriendsModelFromJson(String str) => FriendsModel.fromJson(json.decode(str));

String FriendsModelToJson(FriendsModel data) => json.encode(data.toJson());

class FriendsModel {
  Data? data;

  FriendsModel({
    this.data,
  });

  factory FriendsModel.fromJson(Map<String, dynamic> json) => FriendsModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  List<Friend>? friends;
  String? status;
  String? mssg;

  Data({
    this.friends,
    this.status,
    this.mssg,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    friends: json["friends"] == null ? [] : List<Friend>.from(json["friends"]!.map((x) => Friend.fromJson(x))),
    status: json["status"],
    mssg: json["mssg"],
  );

  Map<String, dynamic> toJson() => {
    "friends": friends == null ? [] : List<dynamic>.from(friends!.map((x) => x.toJson())),
    "status": status,
    "mssg": mssg,
  };
}

class Friend {
  String? description;
  String? userName;

  Friend({
    this.description,
    this.userName,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    description: json["description"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "user_name": userName,
  };
}
