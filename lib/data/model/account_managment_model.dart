// To parse this JSON data, do
//
//     final accountManagementModel = accountManagementModelFromJson(jsonString);

import 'dart:convert';

AccountManagementModel accountManagementModelFromJson(String str) => AccountManagementModel.fromJson(json.decode(str));

String accountManagementModelToJson(AccountManagementModel data) => json.encode(data.toJson());

class AccountManagementModel {
  Data? data;

  AccountManagementModel({
    this.data,
  });

  factory AccountManagementModel.fromJson(Map<String, dynamic> json) => AccountManagementModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? mssg;
  String? status;
  String? userId;

  Data({
    this.mssg,
    this.status,
    this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mssg: json["mssg"],
    status: json["status"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "mssg": mssg,
    "status": status,
    "user_id": userId,
  };
}
