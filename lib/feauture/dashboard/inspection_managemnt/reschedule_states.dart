
import '../../../api_service/failure/error_handling.dart';

abstract class RescheduleStates{}

class RescheduleInspectionInitial extends RescheduleStates {}
class RescheduleInspectionLoading extends RescheduleStates {}
class RescheduleInspectionSuccess extends RescheduleStates {
  final String message;
  RescheduleInspectionSuccess({required this.message});
}
class RescheduleInspectionError extends RescheduleStates {
  final Failure error;
  RescheduleInspectionError({required this.error});
}


