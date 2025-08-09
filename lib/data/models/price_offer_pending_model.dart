import 'package:ankh_project/domain/entities/price_offer_pending_entity.dart';

class PriceOfferPendingModel extends PriceOfferPendingEntity {
  const PriceOfferPendingModel({
    required super.id,
    required super.marketerName,
    required super.productName,
    required super.productImage,
    required super.clientName,
    required super.clientPhone,
    required super.createdAt,
    required super.status,
    required super.requestedPrice,
  });

  factory PriceOfferPendingModel.fromJson(Map<String, dynamic> json) {
    return PriceOfferPendingModel(
      id: json['id'],
      marketerName: json['marketerName'],
      productName: json['productName'],
      productImage: json['productImage'],
      clientName: json['clientName'],
      clientPhone: json['clientPhone'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
      requestedPrice: (json['requestedPrice'] as num).toDouble(),
    );
  }
}
