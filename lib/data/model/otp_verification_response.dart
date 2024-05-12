// To parse this JSON data, do
//
//     final otpVerificationResponse = otpVerificationResponseFromJson(jsonString);

import 'dart:convert';

OtpVerificationResponse otpVerificationResponseFromJson(String str) => OtpVerificationResponse.fromJson(json.decode(str));

String otpVerificationResponseToJson(OtpVerificationResponse data) => json.encode(data.toJson());

class OtpVerificationResponse {
  bool verificationStatusCopy;
  String verifyCopy;

  OtpVerificationResponse({
    required this.verificationStatusCopy,
    required this.verifyCopy,
  });

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) => OtpVerificationResponse(
    verificationStatusCopy: json["verification_status_copy"],
    verifyCopy: json["verify_copy"],
  );

  Map<String, dynamic> toJson() => {
    "verification_status_copy": verificationStatusCopy,
    "verify_copy": verifyCopy,
  };
}
