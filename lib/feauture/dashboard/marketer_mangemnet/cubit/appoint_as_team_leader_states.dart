import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:equatable/equatable.dart';

abstract class AppointAsTeamLeaderState extends Equatable {
  const AppointAsTeamLeaderState();

  @override
  List<Object?> get props => [];
}

class AppointAsTeamLeaderInitial extends AppointAsTeamLeaderState {}

class AppointAsTeamLeaderLoading extends AppointAsTeamLeaderState {}

class AppointAsTeamLeaderSuccess extends AppointAsTeamLeaderState {
  final String? response;

  const AppointAsTeamLeaderSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class AppointAsTeamLeaderFailure extends AppointAsTeamLeaderState {
  final Failure failure;

  const AppointAsTeamLeaderFailure(this.failure);

  @override
  List<Object?> get props => [failure];
} 