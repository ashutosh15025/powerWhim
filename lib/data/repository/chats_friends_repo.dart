import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/chats/add_chat_model.dart';
import 'package:powerwhim/data/model/chats/chat_end_reason_model.dart';
import 'package:powerwhim/data/model/chats/chats_details_model.dart';
import 'package:powerwhim/data/model/chats/friends_model.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:retrofit/dio.dart';

import '../model/chats/chat_details_model.dart';

abstract class ChatsFriendsRepo{
  Future<HttpResponse<ChatsDetailsModel>> getChats(String userId,int activeChatStatu);
  Future<HttpResponse<PersonalChatModel>> getPersonalChat(String chatId,int page,String userId);


  Future<HttpResponse<AccountManagementModel>> setSocketId(String userId, String socketId);


  Future<HttpResponse<FriendsModel>> getconnection(String userId);

  Future<HttpResponse<AddChatModel>> setChats(String fromUserId ,String toUserId, int addtoNetwork);

  Future<HttpResponse<AccountManagementModel>> startEndChats(String userId ,String chatId,int ? deactivate_on,int ? block,int ? startChat);

  Future<HttpResponse<ChatEndReasonModel>> getChatEndReason();

  Future<HttpResponse<ChatConnectionDetailsModel>> getChatsDetails(String userId);

}