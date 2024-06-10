import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/sport_hobbies_model.dart';

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
    if (response.response.statusCode == HttpStatus.ok &&
        response.data.data != null &&
        response.data.data?.status != null) {
      print(response.data.data!.status.toString() +
          " " +
          STATUS.success.toString());

      switch (response.data.data!.status) {
        case "success":
          {
            USER_ID = response.data.data?.userId;
            emit(AuthRegistorSuccessState(
                response.data.data!.mssg!, response.data.data!.userId));
          }
        default:
          emit(ApiFailedState(response.data.data!.mssg!));
      }
    } else {
      print("ashes");
      emit(ApiFailedState(ERROR));
    }
  }

  void onVerifyOTPsEvent(VerifyOTPsEvent event, Emitter<AuthState> emit) async {
    print(USER_ID.toString());
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
            print(response.data.data!.mssg! + "success");
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

      print("login api respose");
      if (response.response.statusCode == HttpStatus.ok &&
          response.data.data != null &&
          response.data.data?.status != null) {
        switch (response.data.data!.status) {
          case "Success":
            {
              print(response.data.data!.mssg!);
              USER_ID = response.data.data!.userId!;
              print(response.data.data!.userId!+" user id");
              print(USER_ID);

              emit(LoginSuccessState(response.data.data!.mssg!));
            }
          default:
            emit(ApiFailedState(response.data.data!.mssg!));
        }
      } else {
        emit(ApiFailedState("email password not match"));
      }
    } catch (e) {
      emit(ApiFailedState(ERROR));
    }
  }

  void onCreatePasswordEvent(
      CreatePasswordEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());

    print("create password clicked");
    var response = await locator
        .get<AccountManagmentUsecase>()
        .createPassword(userId: USER_ID!, password: event.password);
    print(
        "create password clicked + ${response.data.data!.status!.toString()}");

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
    var response = await locator
        .get<AccountManagmentUsecase>()
        .addProfile(addProfileModel: event.addProfileModel);
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
            print("sports");
            sportsList = response.data!.data!.list!;
            emit(GetSportsSuccessState(response.data!.data!.list!));
            print(sportsList);

          }
        default:
          {
            emit(ApiFailedState(response.data.data!.mssg!));
          }
      }
    } else {
      emit(ApiFailedState(ERROR));
    }}catch(error){
      print(error);
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
            hobbiesList = response.data!.data!.list!;
            emit(GetHobbiesSuccessState(response.data!.data!.list!));

            print(hobbiesList);

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
          {   print(response.data.data!.mssg);
              print("complet + run");
              // emit(ApiFailedState("mssg"));
              emit(CompleteProfileState());
          }
        case "pending":
          {
            print("pending");

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
