import 'package:ankh_project/api_service/failure/error_handling.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  AuthFailure error;
  SignInFailure(this.error);
}
