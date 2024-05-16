import 'package:retrofit/dio.dart';


import '../../data/model/account_managment_model.dart';
import '../../data/repository/auth_user_repo.dart';
import '../service/auth_user_service.dart';

class AuthUserRepoImp implements AuthUserRepo{
  final AuthUserService authUserService;
  AuthUserRepoImp(this.authUserService);

  Future<HttpResponse<AccountManagementModel>> registerUser(String email){
    var requestBody = {
      "email_id" : email,
    };
    return authUserService.registerUser(requestBody);
  }

  @override
  Future<HttpResponse<AccountManagementModel>> verifyOTP(String userId, String OTP) {
    var requestBody = {
      "user_id" : userId,
      "verify_otp" : OTP,
    };
    return authUserService.oTPVerifcation(requestBody);
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
    // TODO: implement loginUser
    throw UnimplementedError();
  }


}