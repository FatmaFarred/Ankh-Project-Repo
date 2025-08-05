import '../entities/process_installment_request_entity.dart';
import '../repositries_and_data_sources/repositries/installment_actions_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProcessInstallmentRequestUseCase {
  final InstallmentActionsRepository repository;

  ProcessInstallmentRequestUseCase(this.repository);

  Future<void> call(int id, ProcessInstallmentRequestEntity entity) {
    return repository.processInstallmentRequest(id: id, request: entity);
  }
}
