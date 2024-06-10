// To parse this JSON data, do
//
//     final personalChatModel = personalChatModelFromJson(jsonString);

import 'dart:convert';

PersonalChatModel personalChatModelFromJson(String str) => PersonalChatModel.fromJson(json.decode(str));

String personalChatModelToJson(PersonalChatModel data) => json.encode(data.toJson());

class PersonalChatModel {
  Data? data;

  PersonalChatModel({
    this.data,
  });

  factory PersonalChatModel.fromJson(Map<String, dynamic> json) => PersonalChatModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  List<Message>? messages;
  String? status;
  String? mssg;
  int? total;
  bool? activeChats;

  Data({
    this.messages,
    this.status,
    this.mssg,
    this.total,
    this.activeChats,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
    status: json["status"],
    mssg: json["mssg"],
    total: json["total"],
    activeChats: json["active_chats"],
  );

  Map<String, dynamic> toJson() => {
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    "status": status,
    "mssg": mssg,
    "total": total,
    "active_chats": activeChats,
  };
}

class Message {
  String? conversationMessage;
  DateTime? createdOn;
  dynamic userId;
  dynamic image;

  Message({
    this.conversationMessage,
    this.createdOn,
    this.userId,
    this.image,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    conversationMessage: json["conversation_message"],
    createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    userId: json["user_id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "conversation_message": conversationMessage,
    "created_on": createdOn?.toIso8601String(),
    "user_id": userId,
    "image": image,
  };
}
