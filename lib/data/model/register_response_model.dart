// To parse this JSON data, do
//
//     final registerUserResponse = registerUserResponseFromJson(jsonString);

import 'dart:convert';

RegisterUserResponse registerUserResponseFromJson(String str) => RegisterUserResponse.fromJson(json.decode(str));

String registerUserResponseToJson(RegisterUserResponse data) => json.encode(data.toJson());

class RegisterUserResponse {
  String varificationcode;
  IUser iUser;

  RegisterUserResponse({
    required this.varificationcode,
    required this.iUser,
  });

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) => RegisterUserResponse(
    varificationcode: json["varificationcode"],
    iUser: IUser.fromJson(json["iUser"]),
  );

  Map<String, dynamic> toJson() => {
    "varificationcode": varificationcode,
    "iUser": iUser.toJson(),
  };
}

class IUser {
  int affected;
  String identity;

  IUser({
    required this.affected,
    required this.identity,
  });

  factory IUser.fromJson(Map<String, dynamic> json) => IUser(
    affected: json["affected"],
    identity: json["identity"],
  );

  Map<String, dynamic> toJson() => {
    "affected": affected,
    "identity": identity,
  };
}
