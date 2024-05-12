import 'dart:core';


import 'package:retrofit/dio.dart';

import '../../../base/usecase.dart';
import '../../../data/model/otp_verification_response.dart';
import '../../../domain/repository/auth_user_repo_imp.dart';

class OtpVerifyUsecase implements UseCase<OtpVerificationResponse,UserOTPInput>{
  final AuthUserRepoImp _authUserRepoImp;
   OtpVerifyUsecase(this._authUserRepoImp);
  @override
  Future<HttpResponse<OtpVerificationResponse>> call({ UserOTPInput ?params}) {
    return _authUserRepoImp.verifyOTP(params!.email, params.otp);
  }

}
class UserOTPInput{
   String email;
   String otp;
  UserOTPInput({required this.email,required this.otp});

}