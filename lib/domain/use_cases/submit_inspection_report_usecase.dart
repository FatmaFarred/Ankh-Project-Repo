import 'package:injectable/injectable.dart';
import '../entities/inspection_submission_entity.dart';
import '../repositries_and_data_sources/repositries/inspection_submission_repository.dart';

@injectable
class SubmitInspectionReportUseCase {
  final InspectionSubmissionRepository repository;

  SubmitInspectionReportUseCase(this.repository);

  Future<void> call(InspectionSubmissionEntity entity) {
    return repository.submitInspection(entity);
  }
}