import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/chats/add_chat_model.dart';
import 'package:powerwhim/data/model/chats/chat_details_model.dart';
import 'package:powerwhim/data/model/chats/chat_end_reason_model.dart';
import 'package:powerwhim/data/model/chats/chats_details_model.dart';
import 'package:powerwhim/data/model/chats/friends_model.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:powerwhim/data/repository/chats_friends_repo.dart';
import 'package:powerwhim/domain/service/chatsfriendsservice/chats_friends_service.dart';
import 'package:retrofit/dio.dart';

import '../../constant/service_api_constant.dart';

class ChatsFriendsRepoImp extends ChatsFriendsRepo {
  ChatsFriendsService _chatsFriendsService;

  ChatsFriendsRepoImp(this._chatsFriendsService);

  @override
  Future<HttpResponse<ChatsDetailsModel>> getChats(String userId,int activeChatStatus) {
    print(userId);
    return _chatsFriendsService.getChats(userId,activeChatStatus);
  }

  @override
  Future<HttpResponse<PersonalChatModel>> getPersonalChat(String chatId,int page,String userId) {
    return _chatsFriendsService.getPersonalChat(chatId,page,userId);
  }

  @override
  Future<HttpResponse<AccountManagementModel>> setSocketId(String userId, String socketId) {
    return _chatsFriendsService.setSockedId(userId, socketId);
  }

  @override
  Future<HttpResponse<FriendsModel>> getconnection(String userId) {
    return _chatsFriendsService.getConnection(userId);
  }

  @override
  Future<HttpResponse<AddChatModel>> setChats(String fromUserId, String toUserId,int addToNetwork) {
    print(toUserId);
    print(fromUserId);
    return _chatsFriendsService.setChats(fromUserId,toUserId,addToNetwork);
  }

  @override
  Future<HttpResponse<AccountManagementModel>> startEndChats(String userId, String chatId, int ? deactivate_on,int ? block,int ? startChat) {
    var requestBody = {"user_id": userId,"chat_id":chatId,"deactivate_on":deactivate_on,"block":block,"start_chat":startChat};
    print(requestBody);
    print("print request body");
    return _chatsFriendsService.startEndChats(requestBody);
  }


  @override
  Future<HttpResponse<ChatEndReasonModel>> getChatEndReason() {
    return _chatsFriendsService.getChatEndReason();
  }

  @override
  Future<HttpResponse<ChatConnectionDetailsModel>> getChatsDetails(String userId) {
      return _chatsFriendsService.getChatDetails(userId, USER_ID!);
  }

}
