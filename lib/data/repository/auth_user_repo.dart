import 'package:retrofit/dio.dart';

import '../model/otp_verification_response.dart';
import '../model/register_response_model.dart';

abstract class AuthUserRepo{
  Future<HttpResponse<RegisterUserResponse>> registerUser(String email);
  Future<HttpResponse<OtpVerificationResponse>> verifyOTP(String email,String OTP);
  Future<HttpResponse<OtpVerificationResponse>> createPassword(String email,String password);
  Future<HttpResponse<OtpVerificationResponse>> forgotPassword(String email);
  Future<HttpResponse<OtpVerificationResponse>> loginUser(String email,String password);



}