import 'package:ankh_project/domain/use_cases/appoint_as_team_leader_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../../core/customized_widgets/shared_preferences .dart';
import 'appoint_as_team_leader_states.dart';

@injectable
class AppointAsTeamLeaderCubit extends Cubit<AppointAsTeamLeaderState> {
  AppointAsTeamLeaderUseCase appointAsTeamLeaderUseCase;

  AppointAsTeamLeaderCubit(this.appointAsTeamLeaderUseCase) : super(AppointAsTeamLeaderInitial());

  Future<void> appointAsTeamLeader(String userId, String role) async {
    emit(AppointAsTeamLeaderLoading());
    
    try {
      final token = await SharedPrefsManager.getData(key: 'user_token');
      if (token == null) {
        emit(AppointAsTeamLeaderFailure(Failure(errorMessage: 'Token not found')));
        return;
      }

      final either = await appointAsTeamLeaderUseCase.appointAsTeamLeader(userId, role, token);
      
      either.fold(
        (failure) => emit(AppointAsTeamLeaderFailure(failure)),
        (response) => emit(AppointAsTeamLeaderSuccess(response)),
      );
    } catch (e) {
      emit(AppointAsTeamLeaderFailure(Failure( errorMessage:e.toString())));
    }
  }
} 