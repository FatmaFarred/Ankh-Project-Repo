import '../../entities/installment_pending_entity.dart';

abstract class InstallmentPendingRepository {
  Future<List<InstallmentPendingEntity>> getPendingInstallmentRequests();
  Future<void> updateInstallmentStatus({
    required int id,
    required int status,
    required String adminNote,
  });
}
