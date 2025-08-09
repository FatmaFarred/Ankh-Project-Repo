import 'package:ankh_project/domain/entities/installment_request_entity.dart';

class InstallmentRequestModel extends InstallmentRequestEntity {
  InstallmentRequestModel({
    required super.marketerId,
    required super.productId,
    required super.clientName,
    required super.clientPhone,
    required super.installmentPeriod,
    required super.downPayment,
  });

  Map<String, dynamic> toJson() {
    return {
      "marketerId": marketerId,
      "productId": productId,
      "clientName": clientName,
      "clientPhone": clientPhone,
      "installmentPeriod": installmentPeriod,
      "downPayment": downPayment,
    };
  }
}
