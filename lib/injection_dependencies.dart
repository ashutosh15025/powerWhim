import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/usecase/account_managment_usecase.dart';
import 'domain/repository/auth_user_repo_imp.dart';
import 'domain/service/auth_user_service.dart';

final locator = GetIt.instance;
Future<void> injectionDependencies() async {
  locator.registerSingleton<Dio>(Dio());
  locator.registerSingleton<AuthUserService>(AuthUserService(locator()));
  locator.registerSingleton<AuthUserRepoImp>(AuthUserRepoImp(locator()));
  locator.registerSingleton<AccountManagmentUsecase>(AccountManagmentUsecase(locator()));


}