part of 'auth_bloc.dart';


@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}




//Register

final class AuthRegistorSuccessState extends AuthState {
  String mssg ;
  String ? user_id;
  AuthRegistorSuccessState(this.mssg,this.user_id);
}
final class AuthRegistorFailedState extends AuthState {
  String mssg ;
  AuthRegistorFailedState(this.mssg);
}




final class VerifyOTPSuccessState extends AuthState {
  String mssg;
  VerifyOTPSuccessState(this.mssg);

}
final class VerifyOTPSuccessFailed extends AuthState {
  String mssg;
  VerifyOTPSuccessFailed(this.mssg);
}


final class LoginSuccessState extends AuthState {
  String mssg ;
  LoginSuccessState(this.mssg);
}
final class LoginFailedState extends AuthState {
  String mssg ;
  LoginFailedState(this.mssg);
}




final class CreatePasswordSuccessState extends AuthState {
  String mssg ;
  CreatePasswordSuccessState(this.mssg);
}
final class CreatePasswordFailedState extends AuthState {
  String mssg ;
  CreatePasswordFailedState(this.mssg);
}



final class AddProfileSuccessState extends AuthState {
  String mssg ;
  AddProfileSuccessState(this.mssg);
}
final class AddProfileFailedState extends AuthState {
  String mssg ;
  AddProfileFailedState(this.mssg);
}





