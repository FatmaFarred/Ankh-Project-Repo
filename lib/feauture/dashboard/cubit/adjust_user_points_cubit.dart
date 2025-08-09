import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ankh_project/domain/use_cases/adjust_user_points.dart';
import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:injectable/injectable.dart';

part 'adjust_user_points_state.dart';
@injectable

class AdjustUserPointsCubit extends Cubit<AdjustUserPointsState> {
  final AdjustUserPointsUseCase adjustUserPointsUseCase;

  AdjustUserPointsCubit({required this.adjustUserPointsUseCase}) : super(AdjustUserPointsInitial());

  Future<void> adjustUserPoints(String userId, num points, String reason) async {
    emit(AdjustUserPointsLoading());
    
    final result = await adjustUserPointsUseCase.execute(userId, points, reason);
    
    result.fold(
      (failure) => emit(AdjustUserPointsFailure(failure)),
      (success) => emit(AdjustUserPointsSuccess(success)),
    );
  }
} 