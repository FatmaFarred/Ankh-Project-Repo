import '../../domain/entities/inspection_request_details_entity.dart';

class InspectionRequestDetailsModel extends InspectionRequestDetailsEntity {
  const InspectionRequestDetailsModel({
    required super.productName,
    required super.clientName,
    required super.phoneNumber,
    required super.address,
    required super.appointmentDate,
    required super.appointmentTime,
    required super.productImages,
    required super.status,
    required super.inspectionImages,
    required super.inspectorComment,
  });

  factory InspectionRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    return InspectionRequestDetailsModel(
      productName: json['productName'] ?? '',
      clientName: json['clientName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      appointmentDate: DateTime.parse(json['appointmentDate']),
      appointmentTime: json['appointmentTime'] ?? '',
      productImages: List<String>.from(json['productImages'] ?? []),
      status: json['status'] ?? '',
      inspectionImages: List<String>.from(json['inspectionImages'] ?? []),
      inspectorComment: json['inspectorComment'] ?? '',
    );
  }
}
