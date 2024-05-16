part of 'auth_bloc.dart';


@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}




//Register

final class AuthRegistorSuccessState extends AuthState {
  String mssg ;
  AuthRegistorSuccessState(this.mssg);
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





