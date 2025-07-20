import 'package:ankh_project/api_service/failure/error_handling.dart';
import '../../../../domain/entities/authentication_response_entity.dart';

abstract class InspectorRegisterState {}

class InspectorRegisterInitial extends InspectorRegisterState {}

class InspectorRegisterLoading extends InspectorRegisterState {}

class InspectorRegisterSuccess extends InspectorRegisterState {
  AuthenticationResponseEntity response;
  InspectorRegisterSuccess({required this.response});
}

class InspectorRegisterFailure extends InspectorRegisterState {
  Failure error;
  InspectorRegisterFailure({required this.error});
} 