import 'package:ankh_project/domain/entities/price_offers_by_marketer_id_entity.dart';

class PriceOffersByMarketerIdModel extends PriceOffersByMarketerIdEntity {
  const PriceOffersByMarketerIdModel({
    required super.id,
    required super.marketerName,
    required super.productName,
    required super.productImage,
    required super.clientName,
    required super.clientPhone,
    required super.inspectorPoints,
    required super.createdAt,
    required super.status,
    required super.requestedPrice,
    super.adminNote,
    super.processedAt,
  });

  factory PriceOffersByMarketerIdModel.fromJson(Map<String, dynamic> json) {
    return PriceOffersByMarketerIdModel(
      id: json['id'],
      marketerName: json['marketerName'],
      productName: json['productName'],
      productImage: json['productImage'],
      clientName: json['clientName'],
      clientPhone: json['clientPhone'],
      inspectorPoints: json['inspectorPoints'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
      requestedPrice: (json['requestedPrice'] as num).toDouble(),
      adminNote: json['adminNote'],
      processedAt: json['processedAt'] != null
          ? DateTime.parse(json['processedAt'])
          : null,
    );
  }
}
