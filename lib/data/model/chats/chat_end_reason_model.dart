// To parse this JSON data, do
//
//     final chatEndReasonModel = chatEndReasonModelFromJson(jsonString);

import 'dart:convert';

ChatEndReasonModel chatEndReasonModelFromJson(String str) => ChatEndReasonModel.fromJson(json.decode(str));

String chatEndReasonModelToJson(ChatEndReasonModel data) => json.encode(data.toJson());

class ChatEndReasonModel {
  Data? data;

  ChatEndReasonModel({
    this.data,
  });

  factory ChatEndReasonModel.fromJson(Map<String, dynamic> json) => ChatEndReasonModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? status;
  String? mssg;
  List<String>? endReasons;

  Data({
    this.status,
    this.mssg,
    this.endReasons,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    mssg: json["mssg"],
    endReasons: json["endReasons"] == null ? [] : List<String>.from(json["endReasons"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "mssg": mssg,
    "endReasons": endReasons == null ? [] : List<dynamic>.from(endReasons!.map((x) => x)),
  };
}
