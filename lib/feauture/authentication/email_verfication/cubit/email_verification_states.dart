import 'package:ankh_project/api_service/failure/error_handling.dart';

abstract class EmailVerificationState {}

class EmailVerificationInitial extends EmailVerificationState {}

class EmailVerificationLoading extends EmailVerificationState {}

class EmailVerificationSuccess extends EmailVerificationState {
  final String? message;
  EmailVerificationSuccess({this.message});
}

class EmailVerificationFailure extends EmailVerificationState {
  final Failure error;
  EmailVerificationFailure({required this.error});
}

class ResendEmailVerificationLoading extends EmailVerificationState {}

class ResendEmailVerificationSuccess extends EmailVerificationState {
  final String? message;
  ResendEmailVerificationSuccess({this.message});
}

class ResendEmailVerificationFailure extends EmailVerificationState {
  final Failure error;
  ResendEmailVerificationFailure({required this.error});
}
