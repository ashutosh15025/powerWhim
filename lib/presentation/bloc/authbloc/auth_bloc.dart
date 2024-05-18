import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:powerwhim/constant/service_api_constant.dart';

import '../../../data/model/add_profile_model.dart';
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
    on<CreatePasswordEvent>(onCreatePasswordEvent);
    on<AddProfileEvent>(onAddProfileEvent);
  }
  void onRegisterSucessEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    var response = await locator.get<AccountManagmentUsecase>().registerUser(email:event.email);
     if(response.response.statusCode == HttpStatus.ok&&response.data.data!=null&&response.data.data?.status!=null){
       print(response.data.data!.status.toString()+" "+STATUS.success.toString());

       switch(response.data.data!.status){
         case "success":{
           emit(AuthRegistorSuccessState(response.data.data!.mssg!,response.data.data!.userId));}
          default:
            emit(AuthRegistorFailedState(response.data.data!.mssg!));
       }
     }
     else{
       emit(AuthRegistorFailedState(ERROR));
     }
  }

  void onVerifyOTPsEvent(VerifyOTPsEvent event , Emitter<AuthState> emit) async{
    print(USER_ID.toString());
    var response = await locator.get<AccountManagmentUsecase>().verifyOTP(userId: USER_ID!, otp: event.otp);
    if(response.response.statusCode == HttpStatus.ok&&response.data.data!=null&&response.data.data?.status!=null){
      switch(response.data.data!.status){
        case "success":{
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
        case "success":{
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
    print("create password clicked");
    var response = await locator.get<AccountManagmentUsecase>().createPassword(userId: USER_ID!,password:event.password );
    print("create password clicked + ${response.data.data!.status!.toString()}");

    if(response.response.statusCode == HttpStatus.ok&&response.data.data!=null&&response.data.data?.status!=null){
      switch(response.data.data!.status){
        case "success":{
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


  void onAddProfileEvent(AddProfileEvent event , Emitter<AuthState> emit) async{
    print("add profile called");
    var response = await locator.get<AccountManagmentUsecase>().addProfile(addProfileModel: event.addProfileModel);
    if(response.response.statusCode == HttpStatus.ok&&response.data.data!=null&&response.data.data?.status!=null){
      switch(response.data.data!.status){
        case "success":{
          print(response.data.data!.mssg!);
          emit(AddProfileSuccessState(response.data.data!.mssg!));}
        default:
          emit(AddProfileFailedState(response.data.data!.mssg!));
      }
    }
    else{
      emit(AddProfileFailedState(ERROR));
    }
  }


}
