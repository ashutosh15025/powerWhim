



import 'package:dio/dio.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/chats/add_chat_model.dart';
import 'package:powerwhim/data/model/chats/chats_details_model.dart';
import 'package:powerwhim/data/model/chats/friends_model.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'chats_friends_service.g.dart';


@RestApi(baseUrl: BASE_URL)
abstract class ChatsFriendsService{
  factory ChatsFriendsService(Dio dio) = _ChatsFriendsService;


  @GET("api/chats/get-chats")
  Future<HttpResponse<ChatsDetailsModel>> getChats(
      @Query("from_user_id") String userId
      );


  @GET("api/chats/get-conversations")
  Future<HttpResponse<PersonalChatModel>> getPersonalChat(
      @Query("chat_id") String chatId,
      @Query("offset") int page
      );


  @GET("api/socket/update-socket-id")
  Future<HttpResponse<AccountManagementModel>> setSockedId(
      @Query("user_id") String userId,
      @Query("socket_id") String socketId
      );


  @GET("api/connections/get-connections")
  Future<HttpResponse<FriendsModel>> getConnection(
      @Query("user_id") String userId,
      );


  @GET("api/chats/add-chats")
  Future<HttpResponse<AddChatModel>> setChats(
      @Query("from_user_id") String fromUserId,
      @Query("to_user_id") String toUserId,
      );
}