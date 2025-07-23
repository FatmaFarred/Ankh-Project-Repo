import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/inspection_report_details_entity.dart';

@immutable
abstract class MarketerReportDetailsState {}

class MarketerReportDetailsInitial extends MarketerReportDetailsState {}
class MarketerReportDetailsLoading extends MarketerReportDetailsState {}
class MarketerReportDetailsLoaded extends MarketerReportDetailsState {
   InspectionReportDetailsEntity reportDetails;
  MarketerReportDetailsLoaded({ required this.reportDetails});
}
class MarketerReportDetailsError extends MarketerReportDetailsState {
   Failure error;
  MarketerReportDetailsError({required this.error});
} 