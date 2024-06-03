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
  GetNewMessageState(this.time,this.userId,this.messgText);
}


class SetSocketSuccessState extends ChatState {
  String mssg;
  SetSocketSuccessState(this.mssg);
}

class SetChatsSuccessState extends ChatState {
  String mssg;
  String chatId;
  SetChatsSuccessState(this.mssg,this.chatId);
}

class GetFriendsSuccessState extends ChatState {
  FriendsModel friendsModel;
  GetFriendsSuccessState(this.friendsModel);
}

class GetFullProfileSuccessState extends ChatState{
  FullProfileModel fullProfile;
  GetFullProfileSuccessState(this.fullProfile);
}
