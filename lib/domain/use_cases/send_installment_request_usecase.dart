import 'package:ankh_project/domain/entities/installment_request_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/installment_request_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart'; // Make sure this is imported
import '../../../api_service/failure/error_handling.dart'; // For Failure

@injectable
class SendInstallmentRequestUseCase {
  final InstallmentRequestRepository repository;

  SendInstallmentRequestUseCase(this.repository);

  Future<Either<Failure, Unit>> call(InstallmentRequestEntity request) {
    return repository.sendInstallmentRequest(request);
  }
}
