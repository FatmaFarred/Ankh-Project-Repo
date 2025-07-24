class InspectionRequestDetailsEntity {
  final String productName;
  final String clientName;
  final String phoneNumber;
  final String address;
  final DateTime appointmentDate;
  final String appointmentTime;
  final List<String> productImages;
  final String status;
  final List<String> inspectionImages;
  final String inspectorComment;

  const InspectionRequestDetailsEntity({
    required this.productName,
    required this.clientName,
    required this.phoneNumber,
    required this.address,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.productImages,
    required this.status,
    required this.inspectionImages,
    required this.inspectorComment,
  });
}
