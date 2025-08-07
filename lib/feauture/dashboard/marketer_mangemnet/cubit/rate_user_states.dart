import '../../../../api_service/failure/error_handling.dart';

abstract class RateUserState {}

class RateUserInitial extends RateUserState {}

class RateUserLoading extends RateUserState {}

class RateUserSuccess extends RateUserState {
  final String? message;
  RateUserSuccess({required this.message});
}

class RateUserFailure extends RateUserState {
  Failure error;
  RateUserFailure({required this.error});
}
