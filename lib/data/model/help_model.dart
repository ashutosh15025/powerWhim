import 'dart:convert';

HelpModel helpModelFromJson(String str) => HelpModel.fromJson(json.decode(str));

String helpModelToJson(HelpModel data) => json.encode(data.toJson());

class HelpModel {
  String? name;
  String? emailId;
  String? mobileNumber;
  String? message;

  HelpModel({
    this.name,
    this.emailId,
    this.mobileNumber,
    this.message,
  });

  factory HelpModel.fromJson(Map<String, dynamic> json) => HelpModel(
    name: json["name"],
    emailId: json["email_id"],
    mobileNumber: json["mobile_number"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email_id": emailId,
    "mobile_number": mobileNumber,
    "message": message,
  };
}
