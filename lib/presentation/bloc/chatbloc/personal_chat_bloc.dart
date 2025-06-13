import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../constant/service_api_constant.dart';
import '../../../constant/string_constant.dart';
import '../../../data/model/chats/add_chat_model.dart';
import '../../../data/model/chats/chat_details_model.dart';
import '../../../data/model/chats/chats_details_model.dart';
import '../../../data/model/chats/friends_model.dart';
import '../../../data/model/chats/personal_chat_model.dart';
import '../../../data/model/profilemodel/full_profile.dart';
import '../../../data/usecase/chats_friends_usecase.dart';
import '../../../data/usecase/user_profile_usecase.dart';
import '../../../injection_dependencies.dart';


part 'personal_chat_event.dart';
part 'personal_chat_state.dart';

class PersonalChatBloc extends Bloc<PersonalChatEvent, PersonalChatState> {
  List<Message> personalChatList = [];
  PersonalChatBloc() : super(PersonalChatInitial()) {
    on<PersonalChatEvent>((event, emit) {});
    on<GetPersonalChatEvent>(onGetPersonalChatEvent);
    on<SetSocketEvent>(onSetSocketEvent);
    on<SetChatEvent>(onSetChatEvent);
    on<GetFriendsEvent>(onGetFriendsEvent);
    on<GetFullProfileEvent>(onGetFullProfileEvent);
    on<GetStartEndChatsEvent>(onGetStartEndChat);
    on<GetChatEndReasonEvent>(onGetChatEndReason);
    on<getFullProfileEvent>(ongetFullProfileEvent);
  }

  void onGetChatsSuccessEvent(
      GetChatsEvent event, Emitter<PersonalChatState> emit) async {
    var apiResult = await locator
        .get<ChatsFriendsUsecase>()
        .getChats(USER_ID!,event.activeStatus,0);
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
      GetPersonalChatEvent event, Emitter<PersonalChatState> emit) async {
    if(event.page==0)
       emit(Loading());
    if (event.scroll != null) emit(Loading());
    var apiResult = await locator
        .get<ChatsFriendsUsecase>()
        .getPersonalChat(event.chatId, event.page, USER_ID!);
    try {
      if (apiResult.response.statusCode == HttpStatus.ok) {
        if (apiResult.data.data != null) {
          emit(GetPersonalChatSuccessState(apiResult.data));
          if(event.page>0){
            if(apiResult.data.data!.messages!=null&&apiResult.data.data!.messages!.length>0)
              personalChatList.addAll(apiResult.data.data!.messages!);
          }
          else{
            if(apiResult.data.data!.messages!=null&&apiResult.data.data!.messages!.length>0)
              personalChatList=apiResult.data.data!.messages!;
            else
              personalChatList=[];
          }
        } else {
          emit(ErrorState(ERROR));
        }
      }
    } catch (e) {
      emit(ErrorState(ERROR));
    }
  }

  void onSetSocketEvent(SetSocketEvent event, Emitter<PersonalChatState> emit) async {
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

  void onSetChatEvent(SetChatEvent event, Emitter<PersonalChatState> emit) async {
    var apiResult = await locator
        .get<ChatsFriendsUsecase>()
        .setChats(event.fromUserId, event.toUserId,event.addToNetwork);
    try {
      if (apiResult.response.statusCode == HttpStatus.ok) {
        if (apiResult.data.data != null &&
            apiResult.data.data!.status == StringConstant.successState) {
          emit(SetChatsSuccessState(
              apiResult.data));
        } else {
          emit(ErrorState(ERROR));
        }
      }
    } catch (e) {
      emit(ErrorState(ERROR));
    }
  }

  void onGetFriendsEvent(GetFriendsEvent event, Emitter<PersonalChatState> emit) async {
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
      GetFullProfileEvent event, Emitter<PersonalChatState> emit) async {
    var response = await locator
        .get<UserProfileUsecase>()
        .getFullProfiles(event.userId, USER_ID!);
    try {
      emit(GetFullProfileSuccessState(response.data));
    } catch(e) {
      emit(ErrorState(StringConstant.errorProfile));
    }
  }

  void onGetStartEndChat(
      GetStartEndChatsEvent event, Emitter<PersonalChatState> emit) async {
    var response = await locator
        .get<ChatsFriendsUsecase>()
        .startEndChats(USER_ID!, event.chatId,event.block,event.addToNetwork,event.activateChat);
    if (response.data.data != null) {
      if (response.data.data!.status == StringConstant.successState) {
        print("response.data.data!.mssg! ${response.data.data!.mssg!}");
        emit(GetStartEndChatsState(response.data.data!.mssg!));
      } else {
        emit(ErrorState(response.data.data!.mssg!));
      }
    } else {}
  }



  void onGetChatEndReason(
      GetChatEndReasonEvent event, Emitter<PersonalChatState> emit) async {
    var response = await locator
        .get<ChatsFriendsUsecase>()
        .getChatEndReason();
    if (response.data.data != null) {
      if (response.data.data!.status == StringConstant.successState) {
        if(response.data.data!.endReasons!=null)
          CHATENDREASON = response.data.data!.endReasons!;
      } else {
        emit(ErrorState(response.data.data!.mssg!));
      }
    } else {}
  }


  void ongetFullProfileEvent(getFullProfileEvent event,Emitter<PersonalChatState>emit)async{
    var response = await locator.get<UserProfileUsecase>().getFullProfiles(event.userId,USER_ID!);
      if(response.data.data!=null){
        emit(getFullProfileSuccessState(response.data));
    }
    else{
      emit(ErrorState(response.data.data!.mssg!));
    }
  }
}


void ongetChatDetailEvent(getChatDetailEvent event , Emitter<PersonalChatState>emit)async{
  var response = await locator.get<ChatsFriendsUsecase>().getChatDetails(event.userId);

    if(response.data.data!=null){
      emit(getChatDetailsSuccess(response.data));
  }
  else{
    emit(ErrorState(response.data.data!.mssg!));
  }
}

