part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class LoadApiEvent extends ChatEvent {}

class ErrorApiEvent extends ChatEvent {}

class GetChatsEvent extends ChatEvent {}


class GetPersonalChatEvent extends ChatEvent {
  String chatId;
  GetPersonalChatEvent(this.chatId);
}


class GetNewMessageEvent extends ChatEvent {
  String time;
  String userId;
  String messgText;
  GetNewMessageEvent(this.time,this.userId,this.messgText);
}





class SetSocketEvent extends ChatEvent {
  String socketId;
  SetSocketEvent(this.socketId);
}


class GetFriendsEvent extends ChatEvent {
  String userId;
  GetFriendsEvent(this.userId );
}

class SetChatEvent extends ChatEvent {
  String fromUserId;
  String toUserId;
  SetChatEvent(this.fromUserId,this.toUserId);
}

class GetFullProfileEvent extends ChatEvent{
  String userId;
  GetFullProfileEvent(this.userId);
}

