import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../api_service/failure/error_handling.dart';
import '../entities/inspection_submission_entity.dart';
import '../repositries_and_data_sources/repositries/inspection_submission_repository.dart';

@injectable
class SubmitInspectionReportUseCase {
  final InspectionSubmissionRepository repository;

  SubmitInspectionReportUseCase(this.repository);

  Future <Either<Failure,String?>> call(InspectionSubmissionEntity entity) {
    return repository.submitInspection(entity);
  }
}