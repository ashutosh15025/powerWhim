
import 'package:retrofit/dio.dart';

import '../../../base/usecase.dart';
import '../../../data/model/register_response_model.dart';
import '../../../domain/repository/auth_user_repo_imp.dart';

class AuthUserUsecase implements UseCase<RegisterUserResponse,String>{

  final AuthUserRepoImp _authUserRepoImp;
  AuthUserUsecase(this._authUserRepoImp);

  @override
  Future<HttpResponse<RegisterUserResponse>> call({String params="0"}) {
   return  _authUserRepoImp.registerUser(params);
  }


}