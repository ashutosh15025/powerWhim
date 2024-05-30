// To parse this JSON data, do
//
//     final friendsModel = friendsModelFromJson(jsonString);

import 'dart:convert';

FriendsModel friendsModelFromJson(String str) => FriendsModel.fromJson(json.decode(str));

String friendsModelToJson(FriendsModel data) => json.encode(data.toJson());

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
  String? chatId;
  String? userName;
  String? userId;

  Friend({
    this.description,
    this.chatId,
    this.userName,
    this.userId,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    description: json["description"],
    chatId: json["chat_id"],
    userName: json["user_name"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "chat_id": chatId,
    "user_name": userName,
    "user_id": userId,
  };
}
