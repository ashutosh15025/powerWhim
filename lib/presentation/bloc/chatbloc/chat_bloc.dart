import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/constant/string_constant.dart';
import 'package:powerwhim/data/model/chats/add_chat_model.dart';
import 'package:powerwhim/data/model/chats/chats_details_model.dart';
import 'package:powerwhim/data/model/chats/friends_model.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:powerwhim/data/usecase/chats_friends_usecase.dart';
import 'package:powerwhim/injection_dependencies.dart';
import '../../../data/model/chats/chat_details_model.dart';
import '../../../data/model/profilemodel/full_profile.dart';
import '../../../data/usecase/user_profile_usecase.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> personalChatList = [];
  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    on<GetChatsEvent>(onGetChatsSuccessEvent);
    on<SetSocketEvent>(onSetSocketEvent);
    on<SetChatEvent>(onSetChatEvent);
    on<GetFriendsEvent>(onGetFriendsEvent);
    on<GetFullProfileEvent>(onGetFullProfileEvent);
    on<getFullProfileEvent>(ongetFullProfileEvent);
    on<getChatDetailEvent>(ongetChatDetailEvent);
  }

  void onGetChatsSuccessEvent(
      GetChatsEvent event, Emitter<ChatState> emit) async {
    var apiResult = await locator
        .get<ChatsFriendsUsecase>()
        .getChats(USER_ID!, event.activeStatus, 0);
    try {
      if (apiResult.response.statusCode == HttpStatus.ok) {
        if (apiResult.data.data != null &&
            apiResult.data.data!.status == StringConstant.successState) {
          emit(GetChatsSuccessState(apiResult.data));
        } else {
          emit(ErrorState(ERROR));
        }
      }
    } catch (e) {
      emit(ErrorState(ERROR));
    }
  }

  void onGetPersonalChatEvent(
      GetPersonalChatEvent event, Emitter<ChatState> emit) async {
    if (event.scroll != null) emit(LoadingState());
    var apiResult = await locator
        .get<ChatsFriendsUsecase>()
        .getPersonalChat(event.chatId, event.page, USER_ID!);
    try {
      if (apiResult.response.statusCode == HttpStatus.ok) {
        if (apiResult.data.data != null) {
          emit(GetPersonalChatSuccessState(apiResult.data));
          if (event.page > 0) {
            if (apiResult.data.data!.messages != null &&
                apiResult.data.data!.messages!.length > 0)
              personalChatList.addAll(apiResult.data.data!.messages!);
          } else {
            if (apiResult.data.data!.messages != null &&
                apiResult.data.data!.messages!.length > 0)
              personalChatList = apiResult.data.data!.messages!;
            else
              personalChatList = [];
          }
        } else {
          emit(ErrorState(ERROR));
        }
      }
    } catch (e) {
      emit(ErrorState(ERROR));
    }
  }

  void onSetSocketEvent(SetSocketEvent event, Emitter<ChatState> emit) async {
    var apiResult = await locator
        .get<ChatsFriendsUsecase>()
        .setSocketId(event.socketId, USER_ID!);
    try {
      if (apiResult.response.statusCode == HttpStatus.ok) {
        if (apiResult.data.data != null &&
            apiResult.data.data!.status == StringConstant.successState) {
        } else {
          emit(ErrorState(ERROR));
        }
      }
    } catch (e) {
      emit(ErrorState(ERROR));
    }
  }

  void onSetChatEvent(SetChatEvent event, Emitter<ChatState> emit) async {
    var apiResult = await locator
        .get<ChatsFriendsUsecase>()
        .setChats(event.fromUserId, event.toUserId, event.addToNetwork);
    try {
      if (apiResult.response.statusCode == HttpStatus.ok) {
        if (apiResult.data.data != null &&
            apiResult.data.data!.status == StringConstant.successState) {
          emit(SetChatsSuccessState(apiResult.data));
        } else {
          emit(ErrorState(ERROR));
        }
      }
    } catch (e) {
      emit(ErrorState(ERROR));
    }
  }

  void onGetFriendsEvent(GetFriendsEvent event, Emitter<ChatState> emit) async {
    var apiResult =
        await locator.get<ChatsFriendsUsecase>().getConnection(event.userId);
    try {
      if (apiResult.response.statusCode == HttpStatus.ok) {
        if (apiResult.data.data != null &&
            apiResult.data.data!.status == StringConstant.successState) {
          if (apiResult.data.data!.friends == null)
            apiResult.data.data!.friends = [];
          emit(GetFriendsSuccessState(apiResult.data));
        } else {
          emit(ErrorState(ERROR));
        }
      }
    } catch (e) {
      emit(ErrorState(ERROR));
    }
  }

  void onGetFullProfileEvent(
      GetFullProfileEvent event, Emitter<ChatState> emit) async {
    emit(LoadingState());
    var response = await locator
        .get<UserProfileUsecase>()
        .getFullProfiles(event.userId, USER_ID!);
    if (response.data.data != null) {
      emit(GetFullProfileSuccessState(response.data));
    } else {
      emit(ErrorState(StringConstant.errorProfile));
    }
  }

  void ongetFullProfileEvent(
      getFullProfileEvent event, Emitter<ChatState> emit) async {
    var response = await locator
        .get<UserProfileUsecase>()
        .getFullProfiles(event.userId, USER_ID!);
    if (response.data.data != null) {
        emit(getFullProfileSuccessState(response.data));
    } else {
      emit(ErrorState(response.data.data!.mssg!));
    }
  }
}

void ongetChatDetailEvent(
    getChatDetailEvent event, Emitter<ChatState> emit) async {
  var response =
      await locator.get<ChatsFriendsUsecase>().getChatDetails(event.userId);

    if (response.data!.data != null){
      emit(getChatDetailsSuccess(response.data));
  } else {
    emit(ErrorState(response.data.data!.mssg!));
  }
}
