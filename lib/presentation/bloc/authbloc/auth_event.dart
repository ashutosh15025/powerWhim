part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class RegisterSucessEvent extends AuthEvent{}

class VerifyOTPSuccessEvent extends AuthEvent{}

