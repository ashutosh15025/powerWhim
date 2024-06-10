import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/chats/add_chat_model.dart';
import 'package:powerwhim/data/model/chats/chats_details_model.dart';
import 'package:powerwhim/data/model/chats/friends_model.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:retrofit/dio.dart';

import '../../domain/repository/chats_friends_repo_imp.dart';

class ChatsFriendsUsecase {
  final ChatsFriendsRepoImp _chatsFriendsRepoImp;

  ChatsFriendsUsecase(this._chatsFriendsRepoImp);

  Future<HttpResponse<ChatsDetailsModel>> getChats(String userId,int activeChatStatu) {
    return _chatsFriendsRepoImp.getChats(userId,activeChatStatu);
  }

  Future<HttpResponse<PersonalChatModel>> getPersonalChat(String chatId,int page,String userId) {
    return _chatsFriendsRepoImp.getPersonalChat(chatId,page,userId);
  }

  Future<HttpResponse<AccountManagementModel>> setSocketId(String userId,String socketId) {
    return _chatsFriendsRepoImp.setSocketId(socketId,userId);
  }

  Future<HttpResponse<FriendsModel>> getConnection(String userId) {
    return _chatsFriendsRepoImp.getconnection(userId);
  }

  Future<HttpResponse<AddChatModel>> setChats(String fromUserId,String toUserId) {
    return _chatsFriendsRepoImp.setChats(fromUserId, toUserId);
  }

  Future<HttpResponse<AccountManagementModel>> startEndChats(String userId,String chatId,int ? deactivate_on) {
    return _chatsFriendsRepoImp.startEndChats(userId, chatId, deactivate_on);
  }

}
