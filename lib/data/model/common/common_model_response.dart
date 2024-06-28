import 'dart:convert';

CommonResponseModel commonResponseModelFromJson(String str) => CommonResponseModel.fromJson(json.decode(str));

String commonResponseModelToJson(CommonResponseModel data) => json.encode(data.toJson());

class CommonResponseModel {
  Data? data;

  CommonResponseModel({
    this.data,
  });

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) => CommonResponseModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? status;
  String? mssg;

  Data({
    this.status,
    this.mssg,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    mssg: json["mssg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "mssg": mssg,
  };
}
