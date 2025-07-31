import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/request_point_entitty.dart';

abstract class PointsState extends Equatable {
  const PointsState();

  @override
  List<Object?> get props => [];
}

class PointsInitial extends PointsState {
  const PointsInitial();
}

class PointsLoading extends PointsState {
  const PointsLoading();
}

class PointsSuccess extends PointsState {
  final List<RequestPointEntity> pointsRequests;
  final String? message;

  const PointsSuccess({required this.pointsRequests, this.message});

  @override
  List<Object?> get props => [pointsRequests, message];
}

class PointsEmpty extends PointsState {
  final String? message;

  const PointsEmpty({this.message});

  @override
  List<Object?> get props => [message];
}

class PointsError extends PointsState {
  final Failure error;

  const PointsError({required this.error});

  @override
  List<Object?> get props => [error];
}

// States for approve/reject actions
class ApprovePointLoading extends PointsState {
  const ApprovePointLoading();
}

class ApprovePointSuccess extends PointsState {
  final String? response;

  const ApprovePointSuccess({this.response});

  @override
  List<Object?> get props => [response];
}

class ApprovePointError extends PointsState {
  final Failure error;

  const ApprovePointError({required this.error});

  @override
  List<Object?> get props => [error];
}

class RejectPointLoading extends PointsState {
  const RejectPointLoading();
}

class RejectPointSuccess extends PointsState {
  final String? response;

  const RejectPointSuccess({this.response, });

  @override
  List<Object?> get props => [response];
}

class RejectPointError extends PointsState {
  final Failure error;

  const RejectPointError({required this.error});

  @override
  List<Object?> get props => [error, ];
}