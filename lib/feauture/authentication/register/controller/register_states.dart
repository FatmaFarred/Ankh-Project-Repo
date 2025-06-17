import 'package:ankh_project/api_service/failure/error_handling.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  AuthFailure error;
  RegisterFailure(this.error);
}
