import 'package:ankh_project/api_service/failure/error_handling.dart';

import '../../../../domain/entities/register_response_entity.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  RegisterResponseEntity response;
  RegisterSuccess({required this.response});

}

class RegisterFailure extends RegisterState {
  Failure error;

  RegisterFailure({required this.error});
}
