part of 'inspector_management_cubit.dart';

abstract class InspectorManagementState  {

}

class InspectorManagementInitial extends InspectorManagementState {}

class InspectorManagementLoading extends InspectorManagementState {}

class InspectorManagementSuccess extends InspectorManagementState {
   List<AllInspectorsEntity> inspectors;

   InspectorManagementSuccess(this.inspectors);

}

class InspectorManagementEmpty extends InspectorManagementState {}

class InspectorManagementFailure extends InspectorManagementState {
Failure error;
   InspectorManagementFailure(this.error);

}