import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/friends_model.dart';
import 'package:powerwhim/data/model/help_model.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:powerwhim/data/model/profilemodel/my_full_profile_model.dart';
import 'package:powerwhim/data/model/profilemodel/profiles_model.dart';
import 'package:powerwhim/data/repository/user_profile_repo.dart';
import 'package:powerwhim/domain/service/profileservice/user_profile_service.dart';
import 'package:retrofit/dio.dart';

class UserProfileRepoImp extends UserProfileRepo{


  final UserProfileService userProfileService;
  UserProfileRepoImp(this.userProfileService);

  @override
  Future<HttpResponse<FullProfileModel>> getFullProfile(String userId,String myUserId) {
    return userProfileService.getFullProfiles(userId,myUserId);
  }

  @override
  Future<HttpResponse<ProfilesModel>> getProfiles(String userId,String ? search) {
    return userProfileService.getProfiles(userId,search);
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



}