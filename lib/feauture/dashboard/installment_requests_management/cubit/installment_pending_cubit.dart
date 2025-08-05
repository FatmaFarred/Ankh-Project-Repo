import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/installment_pending_entity.dart';
import '../../../../domain/repositries_and_data_sources/repositries/installment_pending_repository.dart';
import 'installment_pending_state.dart';

@injectable
class InstallmentPendingCubit extends Cubit<InstallmentPendingState> {
  final InstallmentPendingRepository _repository;

  List<InstallmentPendingEntity> _allInstallments = [];

  InstallmentPendingCubit(this._repository) : super(InstallmentPendingInitial());

  Future<void> fetchPendingInstallments() async {
    emit(InstallmentPendingLoading());
    try {
      final installments = await _repository.getPendingInstallmentRequests();
      _allInstallments = installments;
      emit(InstallmentPendingLoaded(installments));
    } catch (e) {
      emit(InstallmentPendingError('Failed to fetch installments'));
    }
  }

  Future<void> updateInstallmentStatus({
    required int id,
    required int status,
    required String adminNote,
  }) async {
    emit(InstallmentPendingUpdating());
    try {
      await _repository.updateInstallmentStatus( id: id, status: status, adminNote:adminNote);
      emit(InstallmentPendingUpdated("success")); // or any success state
    } catch (e) {
      emit(InstallmentPendingUpdateError('Failed to update installment status'));
    }
  }

}
