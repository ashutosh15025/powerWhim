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


class GetChatsInactiveSuccessState extends ChatState {
  ChatsDetailsModel chatsDetailsModel;

  GetChatsInactiveSuccessState(this.chatsDetailsModel);
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
  AddChatModel addChatModel;
  SetChatsSuccessState(this.addChatModel);
}

class GetFriendsSuccessState extends ChatState {
  final FriendsModel friendsModel;
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

class GetChatEndReasonState extends ChatState {
  List<String> reasons ;
  GetChatEndReasonState(this.reasons);
}

class getFullProfileSuccessState extends ChatState{
  FullProfileModel fullProfile;
  getFullProfileSuccessState(this.fullProfile);
}


class getChatDetailsSuccess extends ChatState{
  ChatConnectionDetailsModel ? chatConnectionDetailsModel;
  getChatDetailsSuccess(this.chatConnectionDetailsModel);
}