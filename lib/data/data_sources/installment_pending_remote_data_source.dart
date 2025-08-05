import '../models/installment_pending_model.dart';

abstract class InstallmentPendingRemoteDataSource {
  Future<List<InstallmentPendingModel>> getPendingInstallmentRequests();
}
