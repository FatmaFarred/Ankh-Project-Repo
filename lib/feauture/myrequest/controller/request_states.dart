import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';

import '../../../api_service/failure/error_handling.dart';

abstract class MarketerRequestState {}

class MarketerRequestInitial extends MarketerRequestState {}

class MarketerRequestLoading extends MarketerRequestState {}

class MarketerRequestSuccess extends MarketerRequestState {
  final List<MarketerRequestsForInspectionEntity> requests;
  MarketerRequestSuccess({ required this.requests});
}

class MarketerRequestEmpty extends MarketerRequestState {}

class MarketerRequestError extends MarketerRequestState {
  Failure error;
  MarketerRequestError({ required this.error});
}
