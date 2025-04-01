part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class LoadApiEvent extends ChatEvent {}

class ErrorApiEvent extends ChatEvent {}

class GetChatsEvent extends ChatEvent {
  int activeStatus;

  GetChatsEvent(this.activeStatus);
}

class GetPersonalChatEvent extends ChatEvent {
  String chatId;
  int page;
  bool? scroll;

  GetPersonalChatEvent({required this.chatId, required this.page, this.scroll});
}

class GetNewMessageEvent extends ChatEvent {
  String time;
  String userId;
  String messgText;

  GetNewMessageEvent(this.time, this.userId, this.messgText);
}

class SetSocketEvent extends ChatEvent {
  String socketId;

  SetSocketEvent(this.socketId);
}

class GetFriendsEvent extends ChatEvent {
  String userId;

  GetFriendsEvent(this.userId);
}

class SetChatEvent extends ChatEvent {
  String fromUserId;
  String toUserId;
  int addToNetwork;

  SetChatEvent(this.fromUserId, this.toUserId, this.addToNetwork);
}

class GetFullProfileEvent extends ChatEvent {
  String userId;

  GetFullProfileEvent(this.userId);
}







class getFullProfileEvent extends ChatEvent{
  String userId;
  getFullProfileEvent(this.userId);
}


class getChatDetailEvent extends ChatEvent{
  String userId;
  getChatDetailEvent(this.userId);
}
