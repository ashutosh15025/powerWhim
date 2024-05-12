import 'package:retrofit/dio.dart';

import '../../data/model/otp_verification_response.dart';
import '../../data/model/register_response_model.dart';
import '../../data/repository/auth_user_repo.dart';
import '../service/auth_user_service.dart';

class AuthUserRepoImp implements AuthUserRepo{
  final AuthUserService authUserService;
  AuthUserRepoImp(this.authUserService);

  Future<HttpResponse<RegisterUserResponse>> registerUser(String email){
    var requestBody = {
      "email_id" : email,
    };
    return authUserService.registerUser(requestBody);
  }

  @override
  Future<HttpResponse<OtpVerificationResponse>> verifyOTP(String email, String OTP) {
    var requestBody = {
      "email_id" : email,
      "verify_otp" : OTP,
    };
    return authUserService.oTPVerifcation(requestBody);
  }

  @override
  Future<HttpResponse<OtpVerificationResponse>> createPassword(String email, String password) {
    // TODO: implement createPassword
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<OtpVerificationResponse>> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<OtpVerificationResponse>> loginUser(String email, String password) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }


}