import 'package:equatable/equatable.dart';

import '../../../domain/entities/all_marketers_entity.dart';
import '../../../domain/entities/marketer_leader_codes_entity.dart';
import '../../../api_service/failure/error_handling.dart';

abstract class TeamsAndCodesState extends Equatable {
  const TeamsAndCodesState();

  @override
  List<Object?> get props => [];
}

class TeamsAndCodesInitial extends TeamsAndCodesState {}

class TeamsAndCodesLoading extends TeamsAndCodesState {}

class TeamsAndCodesSuccess extends TeamsAndCodesState {
  final List<AllMarketersEntity>? teamMembers;
  final List<MarketerLeaderCodesEntity>? invitationCodes;

  const TeamsAndCodesSuccess({
    this.teamMembers,
    this.invitationCodes,
  });

  @override
  List<Object?> get props => [teamMembers, invitationCodes];
}

class TeamsAndCodesError extends TeamsAndCodesState {
  final Failure error;

  const TeamsAndCodesError(this.error);

  @override
  List<Object?> get props => [error];
} 