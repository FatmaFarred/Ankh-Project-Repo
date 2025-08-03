import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:equatable/equatable.dart';

abstract class InviteTeamMemberState extends Equatable {
  const InviteTeamMemberState();

  @override
  List<Object?> get props => [];
}

class InviteTeamMemberInitial extends InviteTeamMemberState {
  const InviteTeamMemberInitial();
}

class InviteTeamMemberLoading extends InviteTeamMemberState {
  const InviteTeamMemberLoading();
}

class InviteTeamMemberSuccess extends InviteTeamMemberState {
  final List<dynamic> generatedCodes;
  final String? message;

  const InviteTeamMemberSuccess({required this.generatedCodes, this.message});

  @override
  List<Object?> get props => [generatedCodes, message];
}

class InviteTeamMemberError extends InviteTeamMemberState {
  final Failure error;

  const InviteTeamMemberError({required this.error});

  @override
  List<Object?> get props => [error];
} 