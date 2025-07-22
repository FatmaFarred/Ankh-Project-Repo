import 'package:equatable/equatable.dart';
import '../../../../domain/entities/inspection_request_details_entity.dart';

abstract class InspectionRequestDetailsState extends Equatable {
  const InspectionRequestDetailsState();

  @override
  List<Object?> get props => [];
}

class InspectionRequestDetailsInitial extends InspectionRequestDetailsState {}

class InspectionRequestDetailsLoading extends InspectionRequestDetailsState {}

class InspectionRequestDetailsLoaded extends InspectionRequestDetailsState {
  final InspectionRequestDetailsEntity details;

  const InspectionRequestDetailsLoaded(this.details);

  @override
  List<Object?> get props => [details];
}

class InspectionRequestDetailsError extends InspectionRequestDetailsState {
  final String message;

  const InspectionRequestDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
