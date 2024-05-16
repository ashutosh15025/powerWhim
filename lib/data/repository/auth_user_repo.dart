import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:retrofit/dio.dart';



abstract class AuthUserRepo{
  Future<HttpResponse<AccountManagementModel>> registerUser(String email);
  Future<HttpResponse<AccountManagementModel>> verifyOTP(String email,String OTP);
  Future<HttpResponse<AccountManagementModel>> createPassword(String email,String password);
  Future<HttpResponse<AccountManagementModel>> forgotPassword(String email);
  Future<HttpResponse<AccountManagementModel>> loginUser(String userId,String password);



}