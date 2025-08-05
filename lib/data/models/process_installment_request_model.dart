import '../../domain/entities/process_installment_request_entity.dart';

class ProcessInstallmentRequestModel extends ProcessInstallmentRequestEntity {
  ProcessInstallmentRequestModel({
    required super.status,
    required super.adminNote,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'adminNote': adminNote,
    };
  }
}
