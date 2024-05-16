import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:powerwhim/constant/service_api_constant.dart';

import '../../../data/usecase/account_managment_usecase.dart';
import '../../../injection_dependencies.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{

    });
    on<RegisterEvent>(onRegisterSucessEvent);
    on<VerifyOTPsEvent>(onVerifyOTPsEvent);
  }
  void onRegisterSucessEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    var response = await locator.get<AccountManagmentUsecase>().registerUser(email:event.email);
     if(response.response.statusCode == HttpStatus.ok&&response.data.data!=null&&response.data.data?.status!=null){
       switch(response.data.data!.status){
         case STATUS.success:{
           print(response.data.data!.mssg!);
           emit(AuthRegistorSuccessState(response.data.data!.mssg!));}
          default:
            emit(AuthRegistorFailedState(ERROR));
       }
     }
     else{
       emit(AuthRegistorFailedState(ERROR));
     }
  }

  void onVerifyOTPsEvent(VerifyOTPsEvent event , Emitter<AuthState> emit) async{
    var response = await locator.get<AccountManagmentUsecase>().verifyOTP(userId: USER_ID!, otp: event.otp);
    if(response.response.statusCode == HttpStatus.ok&&response.data.data!=null&&response.data.data?.status!=null){
      switch(response.data.data!.status){
        case STATUS.success:{
          print(response.data.data!.mssg!);
          emit(VerifyOTPSuccessState(response.data.data!.mssg!));}
        default:
          emit(VerifyOTPSuccessFailed(ERROR));
      }
    }
    else{
      emit(VerifyOTPSuccessFailed(ERROR));
    }
  }

  void onLoginEvent(LoginEvent event , Emitter<AuthState> emit) async{
    var response = await locator.get<AccountManagmentUsecase>().loginUser(email: event.email,password:event.password );
    if(response.response.statusCode == HttpStatus.ok&&response.data.data!=null&&response.data.data?.status!=null){
      switch(response.data.data!.status){
        case STATUS.success:{
          print(response.data.data!.mssg!);
          emit(LoginSuccessState(response.data.data!.mssg!));}
        default:
          emit(LoginFailedState(ERROR));
      }
    }
    else{
      emit(LoginFailedState(ERROR));
    }
  }

  void onCreatePasswordEvent(CreatePasswordEvent event , Emitter<AuthState> emit) async{
    var response = await locator.get<AccountManagmentUsecase>().createPassword(userId: USER_ID!,password:event.password );
    if(response.response.statusCode == HttpStatus.ok&&response.data.data!=null&&response.data.data?.status!=null){
      switch(response.data.data!.status){
        case STATUS.success:{
          print(response.data.data!.mssg!);
          emit(CreatePasswordSuccessState(response.data.data!.mssg!));}
        default:
          emit(CreatePasswordFailedState(ERROR));
      }
    }
    else{
      emit(CreatePasswordFailedState(ERROR));
    }
  }
}
