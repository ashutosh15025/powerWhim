import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:powerwhim/data/repository/user_profile_repo.dart';
import 'package:powerwhim/data/usecase/user_profile_usecase.dart';
import 'package:powerwhim/domain/repository/user_profile_repo_imp.dart';
import 'package:powerwhim/domain/service/addprofileservice/add_profile_service.dart';
import 'package:powerwhim/domain/service/profileservice/user_profile_service.dart';

import 'data/usecase/account_managment_usecase.dart';
import 'domain/repository/auth_user_repo_imp.dart';
import 'domain/service/auth_user_service.dart';

final locator = GetIt.instance;
Future<void> injectionDependencies() async {
  locator.registerSingleton<Dio>(Dio());
  locator.registerSingleton<AuthUserService>(AuthUserService(locator()));
  locator.registerSingleton<AddProfileService>(AddProfileService(locator()));
  locator.registerSingleton<AuthUserRepoImp>(AuthUserRepoImp(locator(),locator()));
  locator.registerSingleton<AccountManagmentUsecase>(AccountManagmentUsecase(locator()));


  locator.registerSingleton<UserProfileService>(UserProfileService(locator()));
  locator.registerSingleton<UserProfileRepoImp>(UserProfileRepoImp(locator()));
  locator.registerSingleton<UserProfileUsecase>(UserProfileUsecase(locator()));


}