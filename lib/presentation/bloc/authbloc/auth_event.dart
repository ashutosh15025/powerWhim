part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

//register
class RegisterEvent extends AuthEvent {
  String email;
  String forget;

  RegisterEvent(this.email,this.forget);
}

class RegisterFailedEvent extends AuthEvent {}

class RegisterSucessEvent extends AuthEvent {}

//verify otp section
class VerifyOTPsEvent extends AuthEvent {
  String otp;

  VerifyOTPsEvent(this.otp);
}

class VerifyOTPSuccessEvent extends AuthEvent {}

class VerifyOTPFailedEvent extends AuthEvent {}

//password

class CreatePasswordEvent extends AuthEvent {
  String password;

  CreatePasswordEvent(this.password);
}

class CreatePasswordSuccessEvent extends AuthEvent {}

class CreatePasswordFailedEvent extends AuthEvent {}

//login
class LoginEvent extends AuthEvent {
  String email;
  String password;

  LoginEvent(this.email, this.password);
}

class LoginSuccessEvent extends AuthEvent {}

class LoginFailedEvent extends AuthEvent {}

class AddProfileEvent extends AuthEvent {
  AddProfileModel addProfileModel;

  AddProfileEvent(this.addProfileModel);
}

class AddProfileSuccessEvent extends AuthEvent {}

class AddProfileFailedEvent extends AuthEvent {}

class GetSportEvent extends AuthEvent {
  GetSportEvent();
}

class GetHobbiesEvent extends AuthEvent {
  GetHobbiesEvent();
}

class GetCheckProfileEvent extends AuthEvent {
  GetCheckProfileEvent();
}

class GetLoadingEvent extends AuthEvent {
  GetLoadingEvent();
}



