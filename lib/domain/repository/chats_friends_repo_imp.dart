import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/chats/add_chat_model.dart';
import 'package:powerwhim/data/model/chats/chats_details_model.dart';
import 'package:powerwhim/data/model/chats/friends_model.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:powerwhim/data/repository/chats_friends_repo.dart';
import 'package:powerwhim/domain/service/chatsfriendsservice/chats_friends_service.dart';
import 'package:retrofit/dio.dart';

class ChatsFriendsRepoImp extends ChatsFriendsRepo {
  ChatsFriendsService _chatsFriendsService;

  ChatsFriendsRepoImp(this._chatsFriendsService);

  @override
  Future<HttpResponse<ChatsDetailsModel>> getChats(String userId) {
    print(userId);
    return _chatsFriendsService.getChats(userId);
  }

  @override
  Future<HttpResponse<PersonalChatModel>> getPersonalChat(String chatId) {
    return _chatsFriendsService.getPersonalChat(chatId);
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
  Future<HttpResponse<AddChatModel>> setChats(String fromUserId, String toUserId) {
    return _chatsFriendsService.setChats(fromUserId,toUserId);
  }


}
