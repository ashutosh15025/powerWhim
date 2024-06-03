import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/add_profile_model.dart';
import 'package:powerwhim/data/model/sport_hobbies_model.dart';
import 'package:retrofit/dio.dart';



abstract class AuthUserRepo{
  Future<HttpResponse<AccountManagementModel>> registerUser(String email,String forget);
  Future<HttpResponse<AccountManagementModel>> verifyOTP(String email,String OTP);
  Future<HttpResponse<AccountManagementModel>> createPassword(String email,String password);
  Future<HttpResponse<AccountManagementModel>> forgotPassword(String email);
  Future<HttpResponse<AccountManagementModel>> loginUser(String userId,String password);
  Future<HttpResponse<AccountManagementModel>> checkProfile(String userId);



  //addprofile
  Future<HttpResponse<AccountManagementModel>> addProfile(AddProfileModel addProfileModel);
  Future<HttpResponse<SportHobbiesModel>> getSports();
  Future<HttpResponse<SportHobbiesModel>> getHobbies();
}