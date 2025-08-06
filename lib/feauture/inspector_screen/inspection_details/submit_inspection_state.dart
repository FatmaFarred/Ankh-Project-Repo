part of 'submit_inspection_cubit.dart';

abstract class SubmitInspectionState {}

class SubmitInspectionInitial extends SubmitInspectionState {}

class SubmitInspectionLoading extends SubmitInspectionState {}

class SubmitInspectionSuccess extends SubmitInspectionState {
  final String? message;
  SubmitInspectionSuccess({this.message});
}

class SubmitInspectionError extends SubmitInspectionState {
  final String? message;
  SubmitInspectionError({this.message});
}
