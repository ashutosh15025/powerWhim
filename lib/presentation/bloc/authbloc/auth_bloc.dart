import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../../domain/repository/auth_user_repo_imp.dart';
import '../../../injection_dependencies.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{

    });
    on<RegisterSucessEvent>(onRegisterSucessEvent);
    on<VerifyOTPSuccessEvent>(onVerifyOTPSuccessEvent);
  }
  void onRegisterSucessEvent(
      AuthEvent event, Emitter<AuthState> emit) async {
    var response = await locator.get<AuthUserRepoImp>().registerUser("ashutosh615singh@gmail.com");
    print(response.data);
    print("ashesse");
    emit(AuthRegistorSuccessState());
  }

  void onVerifyOTPSuccessEvent(AuthEvent event , Emitter<AuthState> emit) async{
    var response = await locator.get<AuthUserRepoImp>().verifyOTP("ashutosh615singh@gmail.co", "OTP");
    print(response.data);
    emit(VerifyOTPSuccessState());
  }
}
