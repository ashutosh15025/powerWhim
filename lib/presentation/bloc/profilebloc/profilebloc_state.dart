part of 'profilebloc_bloc.dart';

@immutable
sealed class ProfileblocState {}

final class ProfileblocInitial extends ProfileblocState {}




class getProfilesSuccessState extends ProfileblocState{
  ProfilesModel profilesModel;
  getProfilesSuccessState(this.profilesModel);
}
class getProfilesFailedState extends ProfileblocState{
  String mssg;
  getProfilesFailedState(this.mssg);
}





class getFullProfileSuccessState extends ProfileblocState{
  FullProfileModel fullProfile;
  getFullProfileSuccessState(this.fullProfile);
}
class getFullProfileFailedState extends ProfileblocState{
  String mssg;
  getFullProfileFailedState(this.mssg);
}





class getHelpSuccessState extends ProfileblocState{
  String mssg;
  getHelpSuccessState(this.mssg);
}
class getHelpFailedState extends ProfileblocState{
  String mssg;
  getHelpFailedState(this.mssg);
}



class getFriendSuccessState extends ProfileblocState{
  FriendsModel friendsModel;
  getFriendSuccessState(this.friendsModel);
}
class getFriendsFailedState extends ProfileblocState{
  String mssg;
  getFriendsFailedState(this.mssg);
}
