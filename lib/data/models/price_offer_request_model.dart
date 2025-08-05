import 'package:ankh_project/domain/entities/price_offer_request_entity.dart';

class PriceOfferRequestModel extends PriceOfferRequestEntity {
  const PriceOfferRequestModel({
    required super.marketerId,
    required super.productId,
    required super.clientName,
    required super.clientPhone,
    required super.requestedPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      "marketerId": marketerId,
      "productId": productId,
      "clientName": clientName,
      "clientPhone": clientPhone,
      "requestedPrice": requestedPrice,
    };
  }
}
