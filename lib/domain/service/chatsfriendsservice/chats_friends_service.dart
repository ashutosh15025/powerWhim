



import 'package:dio/dio.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/chats/add_chat_model.dart';
import 'package:powerwhim/data/model/chats/chat_end_reason_model.dart';
import 'package:powerwhim/data/model/chats/chats_details_model.dart';
import 'package:powerwhim/data/model/chats/friends_model.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../data/model/chats/chat_details_model.dart';
part 'chats_friends_service.g.dart';


@RestApi(baseUrl: BASE_URL)
abstract class ChatsFriendsService{
  factory ChatsFriendsService(Dio dio) = _ChatsFriendsService;


  @GET("api/chats/get-chats")
  Future<HttpResponse<ChatsDetailsModel>> getChats(
      @Query("from_user_id") String userId,
     @Query("chat_active_status") int chatActiveStatus
  );


  @GET("api/chats/get-conversations")
  Future<HttpResponse<PersonalChatModel>> getPersonalChat(
      @Query("chat_id") String chatId,
      @Query("offset") int page,
      @Query("user_id") String UserId
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
      @Query("add_network") int addToNetwork,
      );


  @POST("api/chats/start-end-chat")
  Future<HttpResponse<AccountManagementModel>> startEndChats(
      @Body() Map<String, dynamic> body
      );


  @GET("api/chats/end-chat-reason")
  Future<HttpResponse<ChatEndReasonModel>> getChatEndReason();



  @GET("api/connections/check-connection-status")
  Future<HttpResponse<ChatConnectionDetailsModel>> getChatDetails(
      @Query("user_id")String userId,
      @Query("my_user_id")String myUserId,
      );

}