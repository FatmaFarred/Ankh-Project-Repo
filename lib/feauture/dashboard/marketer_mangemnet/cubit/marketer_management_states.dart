import 'package:ankh_project/domain/entities/all_marketers_entity.dart';

import '../../../../api_service/failure/error_handling.dart';

abstract class MarketerManagementState {}

class MarketerManagementInitial extends MarketerManagementState {}

class MarketerManagementLoading extends MarketerManagementState {}

class MarketerManagementSuccess extends MarketerManagementState {
  final List<AllMarketersEntity> marketersList;
  MarketerManagementSuccess({required this.marketersList});
}

class MarketerManagementEmpty extends MarketerManagementState {}

class MarketerManagementError extends MarketerManagementState {
  Failure error;
  MarketerManagementError({required this.error});
} 