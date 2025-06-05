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
  AddNetwork? addNetwork;
  String? mssg;
  int? total;
  bool? activeChats;

  Data({
    this.messages,
    this.status,
    this.addNetwork,
    this.mssg,
    this.total,
    this.activeChats,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
    status: json["status"],
    addNetwork: json["addNetwork"] == null ? null : AddNetwork.fromJson(json["addNetwork"]),
    mssg: json["mssg"],
    total: json["total"],
    activeChats: json["active_chats"],
  );

  Map<String, dynamic> toJson() => {
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    "status": status,
    "addNetwork": addNetwork?.toJson(),
    "mssg": mssg,
    "total": total,
    "active_chats": activeChats,
  };
}

class AddNetwork {
  int? status;
  int? count;

  AddNetwork({
    this.status,
    this.count,
  });

  factory AddNetwork.fromJson(Map<String, dynamic> json) => AddNetwork(
    status: json["status"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "count": count,
  };
}

class Message {
  String? conversationMessage;
  DateTime? createdOn;
  String? userId;
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
