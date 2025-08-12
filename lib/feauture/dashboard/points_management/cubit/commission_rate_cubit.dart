import 'package:ankh_project/domain/use_cases/adjust_commission_for_team_leader_use_case.dart';
import 'package:ankh_project/domain/use_cases/get_all_point_price_use_case.dart';
import 'package:ankh_project/domain/use_cases/edit_point_price_use_case.dart';
import 'package:ankh_project/feauture/dashboard/points_management/cubit/point_prices_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../api_service/failure/error_handling.dart';
import '../../../../domain/use_cases/adjust_commission_for_roles_use_case.dart';
import '../../../../l10n/app_localizations.dart';
import 'commission_rate_states.dart';

@injectable
class CommissionRateCubit extends Cubit<CommissionRateStates> {
  final AdjustCommissionForRolesUseCase adjustCommissionForRolesUseCase;
  final AdjustCommissionForTeamLeaderUseCase adjustCommissionForTeamLeaderUseCase;

  CommissionRateCubit({
    required this.adjustCommissionForRolesUseCase,
    required this.adjustCommissionForTeamLeaderUseCase,
  }) : super(CommissionRateInitial());


  Future<void> editRateForRoles(  String token, num commissionRate, String roleName) async {
    emit(CommissionRateLoading());
    var either = await adjustCommissionForRolesUseCase.execute(token, commissionRate, roleName);
    either.fold((error) {
      emit(CommissionRateError(error: error));
    }, (response) {
      emit(CommissionRateSuccess(response: response));
    });
  }


  Future<void> editRateForTeamLeader(  String token, num commissionRate) async {
    emit(CommissionRateLoading());
    var either = await adjustCommissionForTeamLeaderUseCase.execute(token, commissionRate);
    either.fold((error) {
      emit(CommissionRateError(error: error));
    }, (response) {
      emit(CommissionRateSuccess(response: response));
    });
  }

} 