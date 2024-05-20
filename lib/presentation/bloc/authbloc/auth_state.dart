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




final class VerifyOTPSuccessState extends AuthState {
  String mssg;
  VerifyOTPSuccessState(this.mssg);

}


final class LoginSuccessState extends AuthState {
  String mssg ;
  LoginSuccessState(this.mssg);
}





final class CreatePasswordSuccessState extends AuthState {
  String mssg ;
  CreatePasswordSuccessState(this.mssg);
}




final class AddProfileSuccessState extends AuthState {
  String mssg ;
  AddProfileSuccessState(this.mssg);
}



final class LoadingState extends AuthState {
  LoadingState();
}
final class ApiFailedState extends AuthState {
  String mssg ;
  ApiFailedState(this.mssg);
}






