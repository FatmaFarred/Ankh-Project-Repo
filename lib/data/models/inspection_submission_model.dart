import '../../domain/entities/inspection_submission_entity.dart';

class InspectionSubmissionModel extends InspectionSubmissionEntity {
  InspectionSubmissionModel({
    required super.requestInspectionId,
    required super.status,
    required super.inspectorComment,
    required super.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'RequestInspectionId': requestInspectionId,
      'Status': status,
      'InspectorComment': inspectorComment,
      'Images': images,
    };
  }
}
