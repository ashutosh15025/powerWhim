
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../constant/service_api_constant.dart';
import '../../data/model/account_managment_model.dart';
part 'auth_user_service.g.dart';


@RestApi(baseUrl: BASE_URL)
abstract class AuthUserService{
  factory AuthUserService(Dio dio) = _AuthUserService;

  @POST("api/user/register")
  Future<HttpResponse<AccountManagementModel>> registerUser(
      @Body() Map<String, dynamic> body,
      );

  @GET("api/user/verify-otp")
  Future<HttpResponse<AccountManagementModel>> oTPVerifcation(
      @Query("user_id") String userId,
      @Query("verify_otp") String password
      );
  
  @GET("api/user/create-password")
  Future<HttpResponse<AccountManagementModel>>createPassword (
      @Query("user_id") String userId,
      @Query("password") String password
      );

  @GET("api/user/login")
  Future<HttpResponse<AccountManagementModel>>login (
      @Query("email_id") String email,
      @Query("password") String password
      );


  @GET("api/user/check-profile")
  Future<HttpResponse<AccountManagementModel>>checkProfile (
      @Query("user_id") String userId,
      );
  

}