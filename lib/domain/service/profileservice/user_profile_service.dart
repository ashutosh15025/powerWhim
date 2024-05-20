




import 'package:dio/dio.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/friends_model.dart';
import 'package:powerwhim/data/model/help_model.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:powerwhim/data/model/profilemodel/profiles_model.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';



part 'user_profile_service.g.dart';


@RestApi(baseUrl: BASE_URL)
abstract class UserProfileService{
  factory UserProfileService(Dio dio) = _UserProfileService;

  @GET("api/user/profiles")
  Future<HttpResponse<ProfilesModel>> getProfiles();


  @GET("api/user/view-profile")
  Future<HttpResponse<FullProfileModel>> getFullProfiles(
      @Query("user_id")String userId,
      );

  @POST("api/user/help")
  Future<HttpResponse<AccountManagementModel>> getHelp(
      @Body() Map<String, dynamic> body,
      );


  @GET("api/connections/get-connections")
  Future<HttpResponse<FriendsModel>> getFriends(
      @Query("user_id")String userId,
      );

}