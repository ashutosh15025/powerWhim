
import 'dart:convert';

ChatsDetailsModel chatsDetailsModelFromJson(String str) => ChatsDetailsModel.fromJson(json.decode(str));

String chatsDetailsModelToJson(ChatsDetailsModel data) => json.encode(data.toJson());

class ChatsDetailsModel {
  List<Datum>? data;

  ChatsDetailsModel({
    this.data,
  });

  factory ChatsDetailsModel.fromJson(Map<String, dynamic> json) => ChatsDetailsModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? userName;
  dynamic activeTime;
  String? lastConversations;
  DateTime? updatedOn;
  String? chatId;
  String? unreadCount;

  Datum({
    this.userName,
    this.activeTime,
    this.lastConversations,
    this.updatedOn,
    this.chatId,
    this.unreadCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userName: json["user_name"],
    activeTime: json["active_time"],
    lastConversations: json["last_conversations"],
    updatedOn: json["updated_on"] == null ? null : DateTime.parse(json["updated_on"]),
    chatId: json["chat_id"],
    unreadCount: json["unread_count"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "active_time": activeTime,
    "last_conversations": lastConversations,
    "updated_on": updatedOn?.toIso8601String(),
    "chat_id": chatId,
    "unread_count": unreadCount,
  };
}
