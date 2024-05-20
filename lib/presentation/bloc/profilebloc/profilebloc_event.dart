part of 'profilebloc_bloc.dart';

@immutable
sealed class ProfileblocEvent {}


class getProfilesEvent extends ProfileblocEvent{}


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






