

import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/friends_model.dart';
import 'package:powerwhim/data/model/help_model.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:retrofit/dio.dart';

import '../model/profilemodel/profiles_model.dart';

abstract class UserProfileRepo{
  Future<HttpResponse<ProfilesModel>> getProfiles();
  Future<HttpResponse<FullProfileModel>> getFullProfile(String userId);
  Future<HttpResponse<AccountManagementModel>> getHelp(HelpModel helpmodel);
  Future<HttpResponse<FriendsModel>> getFriends(String userId);

}