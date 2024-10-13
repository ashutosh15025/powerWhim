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
  dynamic description;
  String? chatId;
  String? userName;
  dynamic profileUpdated;
  DateTime? deactivateOn;
  dynamic blockedTime;
  dynamic event;
  dynamic eventTime;
  String? userId;
  String? connectionstatus;

  Friend({
    this.description,
    this.chatId,
    this.userName,
    this.profileUpdated,
    this.deactivateOn,
    this.blockedTime,
    this.event,
    this.eventTime,
    this.userId,
    this.connectionstatus,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    description: json["description"],
    chatId: json["chat_id"],
    userName: json["user_name"],
    profileUpdated: json["profile_updated"],
    deactivateOn: json["deactivate_on"] == null ? null : DateTime.parse(json["deactivate_on"]),
    blockedTime: json["blocked_time"],
    event: json["event"],
    eventTime: json["event_time"],
    userId: json["user_id"],
    connectionstatus: json["connectionstatus"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "chat_id": chatId,
    "user_name": userName,
    "profile_updated": profileUpdated,
    "deactivate_on": deactivateOn?.toIso8601String(),
    "blocked_time": blockedTime,
    "event": event,
    "event_time": eventTime,
    "user_id": userId,
    "connectionstatus": connectionstatus,
  };
}
