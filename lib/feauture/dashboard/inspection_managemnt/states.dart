import 'package:ankh_project/domain/entities/all_inpection_entity.dart';
import 'package:ankh_project/domain/entities/all_marketers_entity.dart';

import '../../../../api_service/failure/error_handling.dart';

abstract class InspectionManagementState {}

class InspectionManagementInitial extends InspectionManagementState {}

class InspectionManagementLoading extends InspectionManagementState {}

class InspectionManagementSuccess extends InspectionManagementState {
  final List<AllInpectionEntity> inspectionsList;
  InspectionManagementSuccess({required this.inspectionsList});
}

class InspectionManagementEmpty extends InspectionManagementState {}

class InspectionManagementError extends InspectionManagementState {
  Failure error;
  InspectionManagementError({required this.error});
}

