part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class LoadingState extends ChatState {}

class ErrorState extends ChatState {
  String mssg;

  ErrorState(this.mssg);
}

class GetChatsSuccessState extends ChatState {
  ChatsDetailsModel chatsDetailsModel;

  GetChatsSuccessState(this.chatsDetailsModel);
}

class GetPersonalChatSuccessState extends ChatState {
  PersonalChatModel personalChatModel;

  GetPersonalChatSuccessState(this.personalChatModel);
}

class GetNewMessageState extends ChatState {
  String time;
  String userId;
  String messgText;

  GetNewMessageState(this.time, this.userId, this.messgText);
}

class SetSocketSuccessState extends ChatState {
  String mssg;

  SetSocketSuccessState(this.mssg);
}

class SetChatsSuccessState extends ChatState {
  String mssg;
  String chatId;
  DateTime? deactivate_on;

  SetChatsSuccessState(this.mssg, this.chatId, this.deactivate_on);
}

class GetFriendsSuccessState extends ChatState {
  FriendsModel friendsModel;

  GetFriendsSuccessState(this.friendsModel);
}

class GetFullProfileSuccessState extends ChatState {
  FullProfileModel fullProfile;

  GetFullProfileSuccessState(this.fullProfile);
}

class GetStartEndChatsState extends ChatState {
  String mssg;

  GetStartEndChatsState(this.mssg);
}
