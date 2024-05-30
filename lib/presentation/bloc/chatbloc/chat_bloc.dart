import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/chats/chats_details_model.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:powerwhim/data/usecase/chats_friends_usecase.dart';
import 'package:powerwhim/injection_dependencies.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {

  List<Message> personalChatList = [];
  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    on<GetChatsEvent>(onGetChatsSuccessEvent);
    on<GetPersonalChatEvent>(onGetPersonalChatEvent);
    on<SetSocketEvent>(onSetSocketEvent);
    on<SetChatEvent>(onSetChatEvent);
  }

  void onGetChatsSuccessEvent(
      GetChatsEvent event, Emitter<ChatState> emit) async {
    emit(LoadingState());
    var apiResult = await locator.get<ChatsFriendsUsecase>().getChats(USER_ID!);
    print(apiResult);
    print("hit");
    try {
      if (apiResult.response.statusCode == HttpStatus.ok) {
        print(apiResult.data.data!.length);
        if (apiResult.data != null &&
            apiResult.data.data != null &&
            apiResult.data.data!.length > 0) {
          emit(GetChatsSuccessState(apiResult.data!));
        } else
          emit(ErrorState(ERROR));
      }
    } catch (e) {
      print("not ok");
      emit(ErrorState(ERROR));
    }
  }

  void onGetPersonalChatEvent(
      GetPersonalChatEvent event, Emitter<ChatState> emit) async {
    emit(LoadingState());
    var apiResult = await locator.get<ChatsFriendsUsecase>().getPersonalChat(event.chatId);
    print(apiResult);
    print("get personal chat event");
    try {
      if (apiResult.response.statusCode == HttpStatus.ok) {
        if (apiResult.data != null &&
            apiResult.data.data != null) {
          emit(GetPersonalChatSuccessState(apiResult.data));
        } else
          emit(ErrorState(ERROR));
      }
    } catch (e) {
      print("not ok");
      emit(ErrorState(ERROR));
    }
  }



  void onSetSocketEvent(SetSocketEvent event , Emitter<ChatState> emit) async{
    print("set sockrt");

    print(USER_ID.toString());
    var apiResult = await locator.get<ChatsFriendsUsecase>().setSocketId(event.socketId,USER_ID!);
    print(apiResult);
    print("hit socket");
    print(event.socketId);
    try {
      if (apiResult.response.statusCode == HttpStatus.ok) {
        if (apiResult.data != null &&
            apiResult.data.data != null &&
            apiResult.data.data!.status=="success") {
          print("set sockrt sucesssss");


        } else{
          print("kuch or error"+apiResult.data!.data!.mssg.toString());
          emit(ErrorState(ERROR));}
      }
    } catch (e) {
      print("not ok");
      emit(ErrorState(ERROR));
    }
  }
  
  
  void onSetChatEvent(SetChatEvent event, Emitter<ChatState> emit) async{
    var apiResult = await locator.get<ChatsFriendsUsecase>().setChats(event.fromUserId, event.toUserId);
    print(apiResult);
    print("hit socket");
    try {
      if (apiResult.response.statusCode == HttpStatus.ok) {
        if (apiResult.data != null &&
            apiResult.data.data != null &&
            apiResult.data.data!.status=="success") {
          print(apiResult.data.data!.chatId);
          emit(SetChatsSuccessState(apiResult.data.data!.mssg!, apiResult.data.data!.chatId!));
        }
      else{
          print("kuch or error"+apiResult.data!.data!.mssg.toString());
          emit(ErrorState(ERROR));}
      }
    } catch (e) {
      print("not ok");
      emit(ErrorState(ERROR));
    }
  }
}
