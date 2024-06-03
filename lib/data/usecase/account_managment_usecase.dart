import 'package:powerwhim/data/model/add_profile_model.dart';
import 'package:powerwhim/data/model/sport_hobbies_model.dart';
import 'package:retrofit/dio.dart';

import '../../domain/repository/auth_user_repo_imp.dart';
import '../model/account_managment_model.dart';



class AccountManagmentUsecase{
  final AuthUserRepoImp _authUserRepoImp;
  AccountManagmentUsecase(this._authUserRepoImp);

  Future<HttpResponse<AccountManagementModel>> verifyOTP({ required String userId, required String otp}) {
    return _authUserRepoImp.verifyOTP(userId, otp);
  }

  Future<HttpResponse<AccountManagementModel>> registerUser({String email="0",required String forget}) {
    return  _authUserRepoImp.registerUser(email,forget);
  }

  Future<HttpResponse<AccountManagementModel>> loginUser({required String email, required String password}) {
    return  _authUserRepoImp.loginUser(email, password);
  }

  Future<HttpResponse<AccountManagementModel>> createPassword({required String userId,required String password}) {
    return  _authUserRepoImp.createPassword(userId,password);
  }

  Future<HttpResponse<AccountManagementModel>> checkProfile({required String userId}) {
    return  _authUserRepoImp.checkProfile(userId);
  }

  Future<HttpResponse<AccountManagementModel>> addProfile({required AddProfileModel addProfileModel}) {
    return  _authUserRepoImp.addProfile(addProfileModel);
  }
  Future<HttpResponse<SportHobbiesModel>> getHobbies() {
    return  _authUserRepoImp.getHobbies();
  }
  Future<HttpResponse<SportHobbiesModel>> getSports() {
    return  _authUserRepoImp.getSports();
  }


}
