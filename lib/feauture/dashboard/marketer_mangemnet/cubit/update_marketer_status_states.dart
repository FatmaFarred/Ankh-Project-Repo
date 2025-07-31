import '../../../../api_service/failure/error_handling.dart';

abstract class UpdateMarketerStatusState {}

class UpdateMarketerStatusInitial extends UpdateMarketerStatusState {}

class UpdateMarketerStatusLoading extends UpdateMarketerStatusState {}

class UpdateMarketerStatusSuccess extends UpdateMarketerStatusState {
  final String? response;
  UpdateMarketerStatusSuccess({required this.response});
}

class UpdateMarketerStatusFailure extends UpdateMarketerStatusState {
  Failure error;
  UpdateMarketerStatusFailure({required this.error});
} 