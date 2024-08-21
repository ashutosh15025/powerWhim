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


class getMyFullProfileSuccessState extends ProfileblocState{
  MyFullProfileModel myFullProfileModel;
  getMyFullProfileSuccessState(this.myFullProfileModel);
}


class getMyFullProfileFailedState extends ProfileblocState{
  String mssg;
  getMyFullProfileFailedState(this.mssg);
}


class setLocationSucess extends ProfileblocState{
  String mssg;
  setLocationSucess(this.mssg);
}

class setLocationFailed extends ProfileblocState{
  String mssg;
  setLocationFailed(this.mssg);
}

class setEventSuccessState extends ProfileblocState{
  String mssg;
  setEventSuccessState(this.mssg);
}

class setRemoveEventSuccessState extends ProfileblocState{
  String mssg;
  setRemoveEventSuccessState(this.mssg);
}

class ErrorState extends ProfileblocState{
  String mssg;
  ErrorState(this.mssg);
}


class LoadingState extends ProfileblocState{
  LoadingState();
}
