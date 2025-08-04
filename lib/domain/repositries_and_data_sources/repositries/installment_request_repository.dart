import 'package:ankh_project/domain/entities/installment_request_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../api_service/failure/error_handling.dart';

abstract class InstallmentRequestRepository {
  Future<Either<Failure, Unit>> sendInstallmentRequest(InstallmentRequestEntity request);
}
