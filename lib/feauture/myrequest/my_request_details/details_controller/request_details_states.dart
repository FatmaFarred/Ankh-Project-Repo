import 'package:ankh_project/domain/entities/marketer_request_inspection_details_entity.dart';
import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';

import '../../../../api_service/failure/error_handling.dart';

abstract class MarketerRequestDetailsState {}

class MarketerRequestDetailsInitial extends MarketerRequestDetailsState {}

class MarketerRequestDetailsLoading extends MarketerRequestDetailsState {}

class MarketerRequestDetailsSuccess extends MarketerRequestDetailsState {
  final MarketerRequestInspectionDetailsEntity requestDetails;
  MarketerRequestDetailsSuccess({ required this.requestDetails});
}


class MarketerRequestDetailsError extends MarketerRequestDetailsState {
  Failure error;
  MarketerRequestDetailsError({ required this.error});
}
