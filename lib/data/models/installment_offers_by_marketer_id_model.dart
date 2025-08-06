import 'package:ankh_project/domain/entities/installment_offers_by_marketer_id_entity.dart';

class InstallmentOffersByMarketerIdModel extends InstallmentOffersByMarketerIdEntity {
  const InstallmentOffersByMarketerIdModel({
    required super.id,
    required super.marketerName,
    required super.productName,
    required super.productImage,
    required super.clientName,
    required super.clientPhone,
    required super.productPrice,
    required super.requestedMonths,
    required super.downPayment,
    required super.status,
    required super.createdAt,
    super.adminNote,
    super.processedAt,
  });

  factory InstallmentOffersByMarketerIdModel.fromJson(Map<String, dynamic> json) {
    return InstallmentOffersByMarketerIdModel(
      id: json['id'],
      marketerName: json['marketerName'],
      productName: json['productName'],
      productImage: json['productImage'],
      clientName: json['clientName'],
      clientPhone: json['clientPhone'],
      productPrice: json['productPrice'],
      requestedMonths: json['requestedMonths'],
      downPayment: (json['downPayment'] as num).toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      adminNote: json['adminNote'],
      processedAt: json['processedAt'] != null
          ? DateTime.parse(json['processedAt'])
          : null,
    );
  }
} 