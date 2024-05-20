import 'package:powerwhim/data/model/add_profile_model.dart';
import 'package:powerwhim/domain/service/addprofileservice/add_profile_service.dart';
import 'package:retrofit/dio.dart';


import '../../data/model/account_managment_model.dart';
import '../../data/repository/auth_user_repo.dart';
import '../service/auth_user_service.dart';

class AuthUserRepoImp implements AuthUserRepo{
  final AuthUserService authUserService;
  final AddProfileService addProfileService;

  AuthUserRepoImp(this.authUserService,this.addProfileService);

  Future<HttpResponse<AccountManagementModel>> registerUser(String email){
    var requestBody = {
      "email_id" : email,
    };
    print(email);
    return authUserService.registerUser(requestBody);
  }

  @override
  Future<HttpResponse<AccountManagementModel>> verifyOTP(String userId, String OTP) {

    return authUserService.oTPVerifcation(userId,OTP);
  }

  @override
  Future<HttpResponse<AccountManagementModel>> createPassword(String userId, String password) {
    return authUserService.createPassword(userId, password);
  }

  @override
  Future<HttpResponse<AccountManagementModel>> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<AccountManagementModel>> loginUser(String email, String password) {
    return authUserService.login(email, password);
  }

  //AddProfile
  @override
  Future<HttpResponse<AccountManagementModel>> addProfile(AddProfileModel addProfileModel) {
   var body = addProfileModel.toJson();
   return addProfileService.addProfile(body);
  }


}