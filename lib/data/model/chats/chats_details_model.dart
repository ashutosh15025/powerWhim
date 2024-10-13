// To parse this JSON data, do
//
//     final chatsDetailsModel = chatsDetailsModelFromJson(jsonString);

import 'dart:convert';

ChatsDetailsModel chatsDetailsModelFromJson(String str) => ChatsDetailsModel.fromJson(json.decode(str));

String chatsDetailsModelToJson(ChatsDetailsModel data) => json.encode(data.toJson());

class ChatsDetailsModel {
  Data? data;

  ChatsDetailsModel({
    this.data,
  });

  factory ChatsDetailsModel.fromJson(Map<String, dynamic> json) => ChatsDetailsModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? status;
  String? mssg;
  List<Chat>? chats;
  String? inactiveChats;

  Data({
    this.status,
    this.mssg,
    this.chats,
    this.inactiveChats,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    mssg: json["mssg"],
    chats: json["chats"] == null ? [] : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))),
    inactiveChats: json["inactiveChats"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "mssg": mssg,
    "chats": chats == null ? [] : List<dynamic>.from(chats!.map((x) => x.toJson())),
    "inactiveChats": inactiveChats,
  };
}

class Chat {
  String? userName;
  String? userId;
  DateTime? activeTime;
  dynamic blockedTime;
  String? lastConversations;
  DateTime? deactivateOn;
  dynamic connectionstatus;
  DateTime? updatedOn;
  String? chatId;
  String? unreadCount;

  Chat({
    this.userName,
    this.userId,
    this.activeTime,
    this.blockedTime,
    this.lastConversations,
    this.deactivateOn,
    this.connectionstatus,
    this.updatedOn,
    this.chatId,
    this.unreadCount,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    userName: json["user_name"],
    userId: json["user_id"],
    activeTime: json["active_time"] == null ? null : DateTime.parse(json["active_time"]),
    blockedTime: json["blocked_time"],
    lastConversations: json["last_conversations"],
    deactivateOn: json["deactivate_on"] == null ? null : DateTime.parse(json["deactivate_on"]),
    connectionstatus: json["connectionstatus"],
    updatedOn: json["updated_on"] == null ? null : DateTime.parse(json["updated_on"]),
    chatId: json["chat_id"],
    unreadCount: json["unread_count"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "user_id": userId,
    "active_time": activeTime?.toIso8601String(),
    "blocked_time": blockedTime,
    "last_conversations": lastConversations,
    "deactivate_on": deactivateOn?.toIso8601String(),
    "connectionstatus": connectionstatus,
    "updated_on": updatedOn?.toIso8601String(),
    "chat_id": chatId,
    "unread_count": unreadCount,
  };
}
