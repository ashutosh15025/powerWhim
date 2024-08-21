import 'package:dio/dio.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/common/common_model_response.dart';
import 'package:powerwhim/data/model/friends_model.dart';
import 'package:powerwhim/data/model/help_model.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:powerwhim/data/model/profilemodel/my_full_profile_model.dart';
import 'package:powerwhim/data/model/profilemodel/profiles_model.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';



part 'user_profile_service.g.dart';


@RestApi(baseUrl: BASE_URL)
abstract class UserProfileService{
  factory UserProfileService(Dio dio) = _UserProfileService;

  @GET("api/profiles/all-profiles")
  Future<HttpResponse<ProfilesModel>> getProfiles(
      @Query("user_id")String userId,
      @Query("search_string")String ? search,
      @Query("page")int page
      );


  @GET("api/user/view-profile")
  Future<HttpResponse<FullProfileModel>> getFullProfiles(
      @Query("user_id")String userId,
      @Query("my_user_id")String myUserId,
      );

  @POST("api/user/help")
  Future<HttpResponse<AccountManagementModel>> getHelp(
      @Body() Map<String, dynamic> body,
      );


  @GET("api/connections/get-connections")
  Future<HttpResponse<FriendsModel>> getFriends(
      @Query("user_id")String userId,
      );

  @GET("api/user/my-profile")
  Future<HttpResponse<MyFullProfileModel>> getMyProfile(
      @Query("user_id")String userId,
      );

  @GET("api/profiles/update-location")
  Future<HttpResponse<CommonResponseModel>> setUpMyLocation(
      @Query("longitude")double longitude,
      @Query("latitude")double latitude,
      @Query("user_id")String UserId
      );

  @POST("api/profiles/add-event")
  Future<HttpResponse<AccountManagementModel>> setEventProfile(
      @Body() Map<String, dynamic> body,
      );



  @GET("api/profiles/delete-event")
  Future<HttpResponse<AccountManagementModel>> setRemoveEventFromProfile(
      @Query("user_id")String userId
      );


}