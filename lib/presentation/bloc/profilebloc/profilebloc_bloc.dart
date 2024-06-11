import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/constant/string_constant.dart';
import 'package:powerwhim/data/model/friends_model.dart';
import 'package:powerwhim/data/model/help_model.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:powerwhim/data/model/profilemodel/my_full_profile_model.dart';
import 'package:powerwhim/data/model/profilemodel/profiles_model.dart';
import 'package:powerwhim/data/usecase/user_profile_usecase.dart';
import 'package:powerwhim/injection_dependencies.dart';

part 'profilebloc_event.dart';
part 'profilebloc_state.dart';

class ProfileblocBloc extends Bloc<ProfileblocEvent, ProfileblocState> {
  ProfileblocBloc() : super(ProfileblocInitial()) {
    on<getProfilesEvent>(ongetProfilesEvent);
    on<getHelpEvent>(ongetHelpEvent);
    on<getFullProfileEvent>(ongetFullProfileEvent);
    on<getMyFullProfileEvent>(ongetMyFullProfileEvent);

  }

  void ongetProfilesEvent(getProfilesEvent event,Emitter<ProfileblocState>emit)async{
    var response = await locator.get<UserProfileUsecase>().getProfiles(USER_ID!);
    if(response.data.data!=null && response.data.data!.profiles!=null && response.data.data!.profiles!.length>0 ){
      emit(getProfilesSuccessState(response.data));
    }
    else{
    }
  }

  void ongetFullProfileEvent(getFullProfileEvent event,Emitter<ProfileblocState>emit)async{
    var response = await locator.get<UserProfileUsecase>().getFullProfiles(event.userId,USER_ID!);
    if(response.data!=null){
      if(response.data!.data!=null)
      emit(getFullProfileSuccessState(response.data));
    }
    else{
    }
  }

  void ongetHelpEvent(getHelpEvent event,Emitter<ProfileblocState>emit)async{
    var response = await locator.get<UserProfileUsecase>().getHelp(event.helpModel);
    if(response.data!=null){
      if(response.data.data!=null && response.data.data!.status == StringConstant.successState)
      emit(getHelpSuccessState(response.data.data!.mssg!));
      else
        emit(getHelpFailedState(response.data.data!.mssg!));
    }
    else{
      emit(getHelpFailedState(StringConstant.somethingWentWrong));
    }
  }


  void ongetFriends(getFriendsEvent event,Emitter<ProfileblocState>emit)async{
    var response = await locator.get<UserProfileUsecase>().getFriend(event.userId);
    if(response.data!=null){
      if(response.data.data!=null && response.data.data!.status==StringConstant.successState)
        emit(getFriendSuccessState(response.data));
      else
        emit(getFriendsFailedState(response.data.data!.mssg!));
    }
    else{
      emit(getHelpFailedState(StringConstant.somethingWentWrong));
    }
  }

  void ongetMyFullProfileEvent(getMyFullProfileEvent event,Emitter<ProfileblocState>emit)async{
    var response = await locator.get<UserProfileUsecase>().getMyFullProfile(event.userId);
    if(response.data!=null){
      if(response.data.data!=null && response.data.data!.status==StringConstant.successState)
        emit(getMyFullProfileSuccessState(response.data));
      else
        emit(getMyFullProfileFailedState(response.data.data!.mssg!));
    }
    else{
      emit(getHelpFailedState(StringConstant.somethingWentWrong));
    }
  }


}
