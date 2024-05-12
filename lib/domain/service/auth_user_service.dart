import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../../constant/service_api_constant.dart';
import '../../data/model/otp_verification_response.dart';
import '../../data/model/register_response_model.dart';
part 'auth_user_service.g.dart';


@RestApi(baseUrl: BASE_URL)
abstract class AuthUserService{
  factory AuthUserService(Dio dio) = _AuthUserService;

  @POST("api/user/register")
  Future<HttpResponse<RegisterUserResponse>> registerUser(
      @Body() Map<String, dynamic> body,
      );

  @POST("api/user/verify-otp")
  Future<HttpResponse<OtpVerificationResponse>> oTPVerifcation(
      @Body() Map<String, dynamic> body,
      );

}