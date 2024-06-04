import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/chats/add_chat_model.dart';
import 'package:powerwhim/data/model/chats/chats_details_model.dart';
import 'package:powerwhim/data/model/chats/friends_model.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:retrofit/dio.dart';

abstract class ChatsFriendsRepo{
  Future<HttpResponse<ChatsDetailsModel>> getChats(String userId);
  Future<HttpResponse<PersonalChatModel>> getPersonalChat(String chatId,int page);


  Future<HttpResponse<AccountManagementModel>> setSocketId(String userId, String socketId);


  Future<HttpResponse<FriendsModel>> getconnection(String userId);

  Future<HttpResponse<AddChatModel>> setChats(String fromUserId ,String toUserId);




}