part of 'adjust_user_points_cubit.dart';

abstract class AdjustUserPointsState extends Equatable {
  const AdjustUserPointsState();

  @override
  List<Object> get props => [];
}

class AdjustUserPointsInitial extends AdjustUserPointsState {}

class AdjustUserPointsLoading extends AdjustUserPointsState {}

class AdjustUserPointsSuccess extends AdjustUserPointsState {
  final String? message;

  const AdjustUserPointsSuccess(this.message);

  @override
  List<Object> get props => [message ?? ''];
}

class AdjustUserPointsFailure extends AdjustUserPointsState {
  final Failure failure;

  const AdjustUserPointsFailure(this.failure);

  @override
  List<Object> get props => [failure];
} 