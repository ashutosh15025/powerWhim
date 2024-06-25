part of 'profilebloc_bloc.dart';

@immutable
sealed class ProfileblocEvent {}


class getProfilesEvent extends ProfileblocEvent{
  String ? searchValue = null;
  getProfilesEvent(this.searchValue);
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






