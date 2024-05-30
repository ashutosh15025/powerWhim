
import 'dart:convert';

AddChatModel addChatModelFromJson(String str) => AddChatModel.fromJson(json.decode(str));

String addChatModelToJson(AddChatModel data) => json.encode(data.toJson());

class AddChatModel {
  Data? data;

  AddChatModel({
    this.data,
  });

  factory AddChatModel.fromJson(Map<String, dynamic> json) => AddChatModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? status;
  String? mssg;
  String? chatId;

  Data({
    this.status,
    this.mssg,
    this.chatId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    mssg: json["mssg"],
    chatId: json["chat_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "mssg": mssg,
    "chat_id": chatId,
  };
}
