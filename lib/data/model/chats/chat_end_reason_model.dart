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
  List<String>? reasons;

  Data({
    this.status,
    this.mssg,
    this.reasons,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    mssg: json["mssg"],
    reasons: json["reasons"] == null ? [] : List<String>.from(json["reasons"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "mssg": mssg,
    "reasons": reasons == null ? [] : List<dynamic>.from(reasons!.map((x) => x)),
  };
}
