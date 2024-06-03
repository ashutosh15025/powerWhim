import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/friends_model.dart';
import 'package:powerwhim/data/model/help_model.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:powerwhim/data/model/profilemodel/profiles_model.dart';
import 'package:powerwhim/data/usecase/user_profile_usecase.dart';
import 'package:powerwhim/injection_dependencies.dart';

part 'profilebloc_event.dart';
part 'profilebloc_state.dart';

class ProfileblocBloc extends Bloc<ProfileblocEvent, ProfileblocState> {
  ProfileblocBloc() : super(ProfileblocInitial()) {
    on<ProfileblocEvent>((event, emit) {
      print("asheses");
    });
    on<getProfilesEvent>(ongetProfilesEvent);
    on<getHelpEvent>(ongetHelpEvent);
    on<getFullProfileEvent>(ongetFullProfileEvent);
  }

  void ongetProfilesEvent(getProfilesEvent event,Emitter<ProfileblocState>emit)async{
    var response = await locator.get<UserProfileUsecase>().getProfiles(USER_ID!);
    if(response.data.data!=null && response.data.data!.profiles!=null && response.data.data!.profiles!.length>0 ){
      emit(getProfilesSuccessState(response.data));
    }
    else{
      print(response.data.data);

      print("can fetch profiles");
    }
  }

  void ongetFullProfileEvent(getFullProfileEvent event,Emitter<ProfileblocState>emit)async{
    print("view full profile");

    var response = await locator.get<UserProfileUsecase>().getFullProfiles(event.userId,USER_ID!);
    print("view full profile");
    print("user Id ${event.userId}");
    if(response.data!=null){
      if(response.data!.data!=null)
      emit(getFullProfileSuccessState(response.data));
    }
    else{
      print("can fetch profiles");
    }
  }

  void ongetHelpEvent(getHelpEvent event,Emitter<ProfileblocState>emit)async{
    var response = await locator.get<UserProfileUsecase>().getHelp(event.helpModel);
    print("response");
    if(response.data!=null){
      if(response.data.data!=null && response.data.data!.status=="success")
      emit(getHelpSuccessState(response.data.data!.mssg!));
      else
        emit(getHelpFailedState(response.data.data!.mssg!));
    }
    else{
      emit(getHelpFailedState("Something went Wrong"));
    }
  }


  void ongetFriends(getFriendsEvent event,Emitter<ProfileblocState>emit)async{
    var response = await locator.get<UserProfileUsecase>().getFriend(event.userId);
    print("response");
    if(response.data!=null){
      if(response.data.data!=null && response.data.data!.status=="success")
        emit(getFriendSuccessState(response.data));
      else
        emit(getFriendsFailedState(response.data.data!.mssg!));
    }
    else{
      emit(getFriendsFailedState("Something went Wrong"));
    }
  }


}
