import '../../entities/inspection_submission_entity.dart';

abstract class InspectionSubmissionRepository {
  Future<void> submitInspection(InspectionSubmissionEntity entity);
}