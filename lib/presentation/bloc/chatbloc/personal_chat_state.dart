part of 'personal_chat_bloc.dart';

@immutable
sealed class PersonalChatState {}

final class PersonalChatInitial extends PersonalChatState {}

class GetStartEndChatsState extends PersonalChatState {
  String mssg;
  GetStartEndChatsState(this.mssg);
}

class Loading extends PersonalChatState {
}


class ErrorState extends PersonalChatState {
  String mssg;

  ErrorState(this.mssg);
}

class GetChatsSuccessState extends PersonalChatState {
  ChatsDetailsModel chatsDetailsModel;

  GetChatsSuccessState(this.chatsDetailsModel);
}

class GetPersonalChatSuccessState extends PersonalChatState {
  PersonalChatModel personalChatModel;

  GetPersonalChatSuccessState(this.personalChatModel);
}

class GetNewMessageState extends PersonalChatState {
  String time;
  String userId;
  String messgText;

  GetNewMessageState(this.time, this.userId, this.messgText);
}

class SetSocketSuccessState extends PersonalChatState {
  String mssg;

  SetSocketSuccessState(this.mssg);
}

class SetChatsSuccessState extends PersonalChatState {
  AddChatModel addChatModel;
  SetChatsSuccessState(this.addChatModel);
}

class GetFriendsSuccessState extends PersonalChatState {
  FriendsModel friendsModel;
  GetFriendsSuccessState(this.friendsModel);
}

class GetFullProfileSuccessState extends PersonalChatState {
  FullProfileModel fullProfile;

  GetFullProfileSuccessState(this.fullProfile);
}



class GetChatEndReasonState extends PersonalChatState {
  List<String> reasons ;
  GetChatEndReasonState(this.reasons);
}

class getFullProfileSuccessState extends PersonalChatState{
  FullProfileModel fullProfile;
  getFullProfileSuccessState(this.fullProfile);
}


class getChatDetailsSuccess extends PersonalChatState{
  ChatConnectionDetailsModel ? chatConnectionDetailsModel;
  getChatDetailsSuccess(this.chatConnectionDetailsModel);
}