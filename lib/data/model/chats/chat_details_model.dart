// To parse this JSON data, do
//
//     final chatConnectionDetailsModel = chatConnectionDetailsModelFromJson(jsonString);

import 'dart:convert';

ChatConnectionDetailsModel chatConnectionDetailsModelFromJson(String str) => ChatConnectionDetailsModel.fromJson(json.decode(str));

String chatConnectionDetailsModelToJson(ChatConnectionDetailsModel data) => json.encode(data.toJson());

class ChatConnectionDetailsModel {
  Data? data;

  ChatConnectionDetailsModel({
    this.data,
  });

  factory ChatConnectionDetailsModel.fromJson(Map<String, dynamic> json) => ChatConnectionDetailsModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? status;
  String? mssg;
  ChatDetails? chatDetails;

  Data({
    this.status,
    this.mssg,
    this.chatDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    mssg: json["mssg"],
    chatDetails: json["chatDetails"] == null ? null : ChatDetails.fromJson(json["chatDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "mssg": mssg,
    "chatDetails": chatDetails?.toJson(),
  };
}

class ChatDetails {
  String? chatId;
  String? fromUserId;
  String? toUserId;
  DateTime? deactivateOn;

  ChatDetails({
    this.chatId,
    this.fromUserId,
    this.toUserId,
    this.deactivateOn,
  });

  factory ChatDetails.fromJson(Map<String, dynamic> json) => ChatDetails(
    chatId: json["chat_id"],
    fromUserId: json["from_user_id"],
    toUserId: json["to_user_id"],
    deactivateOn: json["deactivate_on"] == null ? null : DateTime.parse(json["deactivate_on"]),
  );

  Map<String, dynamic> toJson() => {
    "chat_id": chatId,
    "from_user_id": fromUserId,
    "to_user_id": toUserId,
    "deactivate_on": deactivateOn?.toIso8601String(),
  };
}
