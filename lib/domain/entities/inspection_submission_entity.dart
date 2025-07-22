class InspectionSubmissionEntity {
  final int requestInspectionId;
  final String status;
  final String inspectorComment;
  final List<String> images;

  InspectionSubmissionEntity({
    required this.requestInspectionId,
    required this.status,
    required this.inspectorComment,
    required this.images,
  });
}
