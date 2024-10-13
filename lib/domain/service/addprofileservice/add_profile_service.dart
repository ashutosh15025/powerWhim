

import 'package:dio/dio.dart';
import 'package:powerwhim/data/model/account_managment_model.dart';
import 'package:powerwhim/data/model/sport_hobbies_model.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../constant/service_api_constant.dart';

part 'add_profile_service.g.dart';


@RestApi(baseUrl: BASE_URL)
abstract class AddProfileService{

  factory AddProfileService(Dio dio) = _AddProfileService;
  
  @POST("api/user/add-profile")
  Future<HttpResponse<AccountManagementModel>> addProfile(
  @Body() Map<String, dynamic> body
  );

  @GET("api/sport/get-sport")
  Future<HttpResponse<SportHobbiesModel>>getSports ();


  @GET("api/hobbies/get-hobbies")
  Future<HttpResponse<SportHobbiesModel>>getHobbies ();
}