import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/friends_model.dart';
import 'package:powerwhim/data/model/help_model.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:powerwhim/data/model/profilemodel/my_full_profile_model.dart';
import 'package:powerwhim/data/model/profilemodel/profiles_model.dart';
import 'package:powerwhim/data/repository/user_profile_repo.dart';
import 'package:powerwhim/domain/service/profileservice/user_profile_service.dart';
import 'package:retrofit/dio.dart';

import '../../data/model/common/common_model_response.dart';

class UserProfileRepoImp extends UserProfileRepo{


  final UserProfileService userProfileService;
  UserProfileRepoImp(this.userProfileService);

  @override
  Future<HttpResponse<FullProfileModel>> getFullProfile(String userId,String myUserId) {
    return userProfileService.getFullProfiles(userId,myUserId);
  }

  @override
  Future<HttpResponse<ProfilesModel>> getProfiles(String userId,String ? search,int page) {
    return userProfileService.getProfiles(userId,search,page);
  }

  @override
  Future<HttpResponse<AccountManagementModel>> getHelp(HelpModel helpmodel) {
    var requestBody = {
      "name" : helpmodel.name,
      "email_id" : helpmodel.emailId,
      "message":helpmodel.message,
      "mobile_number":helpmodel.mobileNumber
    };
   return userProfileService.getHelp(requestBody);
  }

  @override
  Future<HttpResponse<FriendsModel>> getFriends(String userId) {
    return userProfileService.getFriends(userId);
  }

  @override
  Future<HttpResponse<MyFullProfileModel>> getMyFullProfile(String userId) {
   return userProfileService.getMyProfile(userId);
  }



  @override
  Future<HttpResponse<CommonResponseModel>> setMyLocation(double longitude, double latitude) {
    return userProfileService.setUpMyLocation(longitude, latitude,USER_ID!);
  }

  @override
  Future<HttpResponse<AccountManagementModel>> setEventProfile(String userId,String event) {
    var requestBody = {
      "event" : event,
      "user_id" : userId
    };
    return userProfileService.setEventProfile(requestBody);
  }

  @override
  Future<HttpResponse<AccountManagementModel>> setRemoveEventFromProfile(String userId) {
    return userProfileService.setRemoveEventFromProfile(userId);
  }

}