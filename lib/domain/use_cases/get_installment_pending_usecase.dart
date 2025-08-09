import 'package:injectable/injectable.dart';
import '../entities/installment_pending_entity.dart';
import '../repositries_and_data_sources/repositries/installment_pending_repository.dart';

@injectable
class GetInstallmentPendingUseCase {
  final InstallmentPendingRepository repository;

  GetInstallmentPendingUseCase(this.repository);

  Future<List<InstallmentPendingEntity>> call() {
    return repository.getPendingInstallmentRequests();
  }
}
