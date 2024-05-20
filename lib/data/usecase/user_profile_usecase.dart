import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/friends_model.dart';
import 'package:powerwhim/data/model/help_model.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:powerwhim/data/model/profilemodel/profiles_model.dart';

import 'package:powerwhim/domain/repository/user_profile_repo_imp.dart';

import 'package:retrofit/dio.dart';

class UserProfileUsecase{
  final UserProfileRepoImp _userProfileRepoImp;
  UserProfileUsecase(this._userProfileRepoImp);

  Future<HttpResponse<ProfilesModel>> getProfiles(){
    return _userProfileRepoImp.getProfiles();
  }

  Future<HttpResponse<FullProfileModel>> getFullProfiles(String userId){
    return _userProfileRepoImp.getFullProfile(userId);
  }

  Future<HttpResponse<AccountManagementModel>> getHelp(HelpModel helpModel){
    return _userProfileRepoImp.getHelp(helpModel);
  }

  Future<HttpResponse<FriendsModel>> getFriend(String userId){
    return _userProfileRepoImp.getFriends(userId);
  }
}