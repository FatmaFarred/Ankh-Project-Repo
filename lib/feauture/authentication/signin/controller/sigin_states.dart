import 'package:ankh_project/api_service/failure/error_handling.dart';

import '../../../../domain/entities/authentication_response_entity.dart';
import '../../../../domain/entities/login_response_entity.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  AuthenticationResponseEntity response;
  SignInSuccess({required this.response});
}

class SignInFailure extends SignInState {
  Failure error;

  SignInFailure({required this.error});
}
