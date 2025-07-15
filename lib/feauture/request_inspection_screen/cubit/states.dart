
import '../../../api_service/failure/error_handling.dart';

abstract class MarketerAddRequestState {}

class MarketerAddRequestInitial extends MarketerAddRequestState {}

class MarketerAddRequestLoading extends MarketerAddRequestState {}

class MarketerAddRequestSuccess extends MarketerAddRequestState {
  final String? response;
  MarketerAddRequestSuccess({ required this.response});
}


class MarketerAddRequestError extends MarketerAddRequestState {
  Failure error;
  MarketerAddRequestError({ required this.error});
}
