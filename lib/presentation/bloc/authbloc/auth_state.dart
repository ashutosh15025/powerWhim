part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthRegistorSuccessState extends AuthState {}

final class VerifyOTPSuccessState extends AuthState {}




