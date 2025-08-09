import 'package:ankh_project/domain/use_cases/accept_point_request_use_case.dart';
import 'package:ankh_project/domain/use_cases/get_all_point_request_use_case.dart';
import 'package:ankh_project/domain/use_cases/reject_point_request_use_case.dart';
import 'package:ankh_project/feauture/dashboard/points_management/cubit/points_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/request_point_entitty.dart';
import '../../../../api_service/failure/error_handling.dart';
import '../../../../l10n/app_localizations.dart';

@injectable
class PointsCubit extends Cubit<PointsState> {
  final GetAllPointRequestUseCase getAllPointRequestUseCase;
  final AcceptPointRequestUseCase acceptPointRequestUseCase;
  final RejectPointRequestUseCase rejectPointRequestUseCase;

  PointsCubit({
    required this.getAllPointRequestUseCase,
    required this.acceptPointRequestUseCase,
    required this.rejectPointRequestUseCase,
  }) : super(PointsInitial());

  Future<void> fetchPointsRequests(BuildContext context,String token, {String? status}) async {
    emit(PointsLoading());
    var either = await getAllPointRequestUseCase.execute(token);
    either.fold((error) {
      emit(PointsError(error: error));
    }, (response) {
      if (response.isEmpty) {
        emit(PointsEmpty(message:AppLocalizations.of(context)!.noRequestsFound));
      } else {
        List<RequestPointEntity> filteredRequests = response;
        // Only filter if status is provided and not 'All'
        if (status != null && status != 'All') {
          filteredRequests = response.where((request) => request.status == status).toList();
        }
        emit(PointsSuccess(pointsRequests: filteredRequests, message: 'Points requests loaded successfully'));
      }
    });
  }

  Future<void> approvePointRequest(String token, String requestId) async {
    emit(ApprovePointLoading());
    var either = await acceptPointRequestUseCase.execute(token, requestId);
    either.fold((error) {
      emit(ApprovePointError(error: error));
    }, (response) {
      emit(ApprovePointSuccess(response: response));
    });
  }

  Future<void> rejectPointRequest(String token, String requestId,String reason) async {
    emit(RejectPointLoading());
    var either = await rejectPointRequestUseCase.execute(token, requestId,reason);
    either.fold((error) {
      emit(RejectPointError(error: error));
    }, (response) {
      emit(RejectPointSuccess(response: response, ));
    });
  }

  String _getErrorMessage(PointsState state) {
    if (state is ApprovePointError) {
      return state.error?.errorMessage??"";
    } else if (state is RejectPointError) {
      return state?.error?.errorMessage??"";
    }
    return 'Unknown error';
  }
} 