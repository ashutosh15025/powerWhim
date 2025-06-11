part of 'personal_chat_bloc.dart';

@immutable
sealed class PersonalChatEvent {}


  class LoadApiEvent extends PersonalChatEvent {}

  class ErrorApiEvent extends PersonalChatEvent {}

  class GetChatsEvent extends PersonalChatEvent {
  int activeStatus;

  GetChatsEvent(this.activeStatus);
  }

  class GetPersonalChatEvent extends PersonalChatEvent {
  String chatId;
  int page;
  bool? scroll;

  GetPersonalChatEvent({required this.chatId, required this.page, this.scroll});
  }

  class GetNewMessageEvent extends PersonalChatEvent {
  String time;
  String userId;
  String messgText;

  GetNewMessageEvent(this.time, this.userId, this.messgText);
  }

  class SetSocketEvent extends PersonalChatEvent {
  String socketId;

  SetSocketEvent(this.socketId);
  }

  class GetFriendsEvent extends PersonalChatEvent {
  String userId;

  GetFriendsEvent(this.userId);
  }

  class SetChatEvent extends PersonalChatEvent {
  String fromUserId;
  String toUserId;
  int addToNetwork;

  SetChatEvent(this.fromUserId, this.toUserId, this.addToNetwork);
  }

  class GetFullProfileEvent extends PersonalChatEvent {
  String userId;
  GetFullProfileEvent(this.userId);
  }

  class GetStartEndChatsEvent extends PersonalChatEvent {
  String userId;
  String chatId;
  int? deactivate_on;
  int? block;
  int? startChat;

  GetStartEndChatsEvent(
  this.userId,
  this.chatId,
  this.deactivate_on,
  {this.block, this.startChat} // Named optional parameters
  );
  }



  class GetChatEndReasonEvent extends PersonalChatEvent {
  GetChatEndReasonEvent();
  }


  class getFullProfileEvent extends PersonalChatEvent{
  String userId;
  getFullProfileEvent(this.userId);
  }


  class getChatDetailEvent extends PersonalChatEvent{
  String userId;
  getChatDetailEvent(this.userId);
  }
