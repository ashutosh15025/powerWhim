part of 'profilebloc_bloc.dart';

@immutable
sealed class ProfileblocEvent {}


class getProfilesEvent extends ProfileblocEvent{
  String  searchValue = "";
  int page = 0;
  getProfilesEvent(this.searchValue,this.page);
}


class getFullProfileEvent extends ProfileblocEvent{
  String userId;
  getFullProfileEvent(this.userId);
}


class getHelpEvent extends ProfileblocEvent{
  HelpModel helpModel;
  getHelpEvent(this.helpModel);
}




class getFriendsEvent extends ProfileblocEvent{
  String userId;
  getFriendsEvent(this.userId);
}


class getMyFullProfileEvent extends ProfileblocEvent{
  String userId;
  getMyFullProfileEvent(this.userId);
}


class setUpMyLocationEvent extends ProfileblocEvent{
  double longitude;
  double latitude;
  setUpMyLocationEvent(this.longitude,this.latitude);
}






