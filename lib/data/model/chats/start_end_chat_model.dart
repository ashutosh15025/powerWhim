import 'dart:convert';

StartEndChatModelToJson startEndChatModelToJsonFromJson(String str) => StartEndChatModelToJson.fromJson(json.decode(str));

String startEndChatModelToJsonToJson(StartEndChatModelToJson data) => json.encode(data.toJson());

class StartEndChatModelToJson {
  String? userId;
  String? chatId;
  String? toDeactivateOn;

  StartEndChatModelToJson({
    this.userId,
    this.chatId,
    this.toDeactivateOn,
  });

  factory StartEndChatModelToJson.fromJson(Map<String, dynamic> json) => StartEndChatModelToJson(
    userId: json["user_id"],
    chatId: json["chat_id"],
    toDeactivateOn: json["to_deactivate_on"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "chat_id": chatId,
    "to_deactivate_on": toDeactivateOn,
  };
}
