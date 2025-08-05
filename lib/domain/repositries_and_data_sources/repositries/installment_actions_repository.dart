import '../../entities/process_installment_request_entity.dart';

abstract class InstallmentActionsRepository {
  Future<void> processInstallmentRequest({
    required int id,
    required ProcessInstallmentRequestEntity request,
  });
}
