import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/constant/string_constant.dart';

import '../../../data/model/add_profile_model.dart';
import '../../../data/usecase/account_managment_usecase.dart';
import '../../../injection_dependencies.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  List<String> sportsList = ["Footabll","Cricket","BasketBall"];

  List<String> hobbiesList = ["photography", "hiking", "camping", "cooking", "baking", "gardening", "gaming", "coding", "playing music"];



  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {});
    on<GetCheckProfileEvent>(onGetCheckProfileEvent);
    on<RegisterEvent>(onRegisterSucessEvent);
    on<VerifyOTPsEvent>(onVerifyOTPsEvent);
    on<CreatePasswordEvent>(onCreatePasswordEvent);
    on<AddProfileEvent>(onAddProfileEvent);
    on<LoginEvent>(onLoginEvent);
    on<GetSportEvent>(onGetSportsEvent);
    on<GetHobbiesEvent>(onGetHobbiesEvent);
    on<GetLoadingEvent>(onGetLoadingEvent);



  }

  void onRegisterSucessEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    print(event.forget.toString());
    var response = await locator
        .get<AccountManagmentUsecase>()
        .registerUser(email: event.email,forget: event.forget);


    print(response.data.data!.status.toString() +"response");

    if (response.response.statusCode == HttpStatus.ok &&
        response.data.data != null &&
        response.data.data?.status != null) {

      switch (response.data.data!.status) {
        case "success":
          {
            emit(AuthRegistorSuccessState(
                response.data.data!.mssg!, response.data.data!.userId));
          }
        default:
          emit(ApiFailedState(response.data.data!.mssg!));
      }
    } else {
      emit(ApiFailedState(ERROR));
    }
  }

  void onVerifyOTPsEvent(VerifyOTPsEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    var response = await locator
        .get<AccountManagmentUsecase>()
        .verifyOTP(userId: USER_ID!, otp: event.otp);
    if (response.response.statusCode == HttpStatus.ok &&
        response.data.data != null &&
        response.data.data?.status != null) {
      switch (response.data.data!.status) {
        case "success":
          {
            emit(VerifyOTPSuccessState(response.data.data!.mssg!));
          }
        default:
          emit(ApiFailedState(response.data.data!.mssg!));
      }
    } else {
      emit(ApiFailedState(ERROR));
    }
  }

  void onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try {
      var response = await locator
          .get<AccountManagmentUsecase>()
          .loginUser(email: event.email, password: event.password);

      if (response.response.statusCode == HttpStatus.ok &&
          response.data.data != null &&
          response.data.data?.status != null) {
        switch (response.data.data!.status) {
          case "Success":
            {
              USER_ID = response.data.data!.userId!;
              emit(LoginSuccessState(response.data.data!.mssg!));
            }
          default:
            emit(ApiFailedState(StringConstant.emailPassNotMatch));
        }
      } else {
        emit(ApiFailedState(StringConstant.emailPassNotMatch));
      }
    } catch (e) {
      emit(ApiFailedState(StringConstant.emailPassNotMatch));
    }
  }

  void onCreatePasswordEvent(
      CreatePasswordEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    var response = await locator
        .get<AccountManagmentUsecase>()
        .createPassword(userId: USER_ID!, password: event.password);
    if (response.response.statusCode == HttpStatus.ok &&
        response.data.data != null &&
        response.data.data?.status != null) {
      switch (response.data.data!.status) {
        case "success":
          {
            emit(CreatePasswordSuccessState(response.data.data!.mssg!));
          }
        default:
          emit(ApiFailedState(response.data.data!.mssg!));
      }
    } else {
      emit(ApiFailedState(ERROR));
    }
  }

  void onAddProfileEvent(AddProfileEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    print(const JsonEncoder.withIndent('  ').convert(event.addProfileModel));
    var response = await locator
        .get<AccountManagmentUsecase>()
        .addProfile(addProfileModel: event.addProfileModel);
    print(response.data.data!.mssg);
    if (response.response.statusCode == HttpStatus.ok &&
        response.data.data != null &&
        response.data.data?.status != null) {
      switch (response.data.data!.status) {
        case "success":
          {
            emit(AddProfileSuccessState(response.data.data!.mssg!));
          }
        default:
          {
            emit(ApiFailedState(response.data.data!.mssg!));
          }
      }
    } else {
      emit(ApiFailedState(ERROR));
    }
  }

  void onGetSportsEvent(GetSportEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try{
    var response = await locator.get<AccountManagmentUsecase>().getSports();
    if (response.response.statusCode == HttpStatus.ok &&
        response.data.data != null &&
        response.data.data?.status != null) {
      switch (response.data.data!.status) {
        case "success":
          {
            sportsList = [""]+ response.data!.data!.list!;
            emit(GetSportsSuccessState(response.data!.data!.list!));
          }
        default:
          {
            emit(ApiFailedState(response.data.data!.mssg!));
          }
      }
    } else {
      emit(ApiFailedState(ERROR));
    }}catch(error){
      emit(ApiFailedState(ERROR));
    }
  }

  void onGetHobbiesEvent(GetHobbiesEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    var response = await locator.get<AccountManagmentUsecase>().getHobbies();
    if (response.response.statusCode == HttpStatus.ok &&
        response.data.data != null &&
        response.data.data?.status != null) {
      switch (response.data.data!.status) {
        case "success":
          {
            hobbiesList = [""]+response.data!.data!.list!;
            emit(GetHobbiesSuccessState(response.data!.data!.list!));
          }
        default:
          {
            emit(ApiFailedState(response.data.data!.mssg!));
          }
      }
    } else {
      emit(ApiFailedState(ERROR));
    }
  }
  void onGetLoadingEvent(GetLoadingEvent event, Emitter<AuthState> emit)  async{
    emit(LoadingState());
  }
  void onGetCheckProfileEvent(GetCheckProfileEvent event, Emitter<AuthState> emit)  async{
    emit(LoadingState());
    var response = await locator.get<AccountManagmentUsecase>().checkProfile(userId: USER_ID!);
    if (response.response.statusCode == HttpStatus.ok &&
        response.data.data != null &&
        response.data.data?.status != null) {
      switch (response.data.data!.status) {
        case "success":
          {
              emit(CompleteProfileState());
          }
        case "pending":
          {
            print(StringConstant.successState);
            emit(PendingProfileState());
          }
        default:
          {
            emit(ApiFailedState(response.data.data!.mssg!));
          }
      }
    } else {
      emit(ApiFailedState(ERROR));
    }
  }
}
