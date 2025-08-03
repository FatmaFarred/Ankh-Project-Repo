import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/all_marketers_entity.dart';
import '../../../domain/entities/marketer_leader_codes_entity.dart';
import '../../../domain/use_cases/get_all_marketer_codes_use_case.dart';
import '../../../domain/use_cases/get_team_member_use_case.dart';
import '../../../api_service/failure/error_handling.dart';
import 'teams_and_codes_states.dart';

@injectable
class TeamsAndCodesCubit extends Cubit<TeamsAndCodesState> {
  final GetAllMarketerCodesUseCase _getAllMarketerCodesUseCase;
  final GetTeamMemberUseCase _getTeamMemberUseCase;

  TeamsAndCodesCubit({
    required GetAllMarketerCodesUseCase getAllMarketerCodesUseCase,
    required GetTeamMemberUseCase getTeamMemberUseCase,
  })  : _getAllMarketerCodesUseCase = getAllMarketerCodesUseCase,
        _getTeamMemberUseCase = getTeamMemberUseCase,
        super(TeamsAndCodesInitial());

  Future<void> getTeamMembers(String userId) async {
    emit(TeamsAndCodesLoading());
    
    final result = await _getTeamMemberUseCase.execute(userId);
    
    result.fold(
      (failure) => emit(TeamsAndCodesError(failure)),
      (teamMembers) => emit(TeamsAndCodesSuccess(teamMembers: teamMembers)),
    );
  }

  Future<void> getInvitationCodes(String token) async {
    emit(TeamsAndCodesLoading());
    
    final result = await _getAllMarketerCodesUseCase.execute(token);
    
    result.fold(
      (failure) => emit(TeamsAndCodesError(failure)),
      (codes) => emit(TeamsAndCodesSuccess(invitationCodes: codes)),
    );
  }

  Future<void> loadBothData(String userId, String token) async {
    emit(TeamsAndCodesLoading());
    
    final teamResult = await _getTeamMemberUseCase.execute(userId);
    final codesResult = await _getAllMarketerCodesUseCase.execute(token);
    
    teamResult.fold(
      (failure) => emit(TeamsAndCodesError(failure)),
      (teamMembers) {
        codesResult.fold(
          (failure) => emit(TeamsAndCodesError(failure)),
          (codes) => emit(TeamsAndCodesSuccess(
            teamMembers: teamMembers,
            invitationCodes: codes,
          )),
        );
      },
    );
  }
} 