import '../../domain/entities/all_point_price_entity.dart';

/// roleName : "Marketer"
/// pricePerPoint : 1000.00
/// priceUpdatedAt : "2025-07-26T19:54:53.8088086"

class AllPointPriceDm extends AllPointPriceEntity {
  AllPointPriceDm({
      super.roleName,
      super.pricePerPoint,
    super.priceUpdatedAt,});

  AllPointPriceDm.fromJson(dynamic json) {
    roleName = json['roleName'];
    pricePerPoint = json['pricePerPoint'];
    priceUpdatedAt = json['priceUpdatedAt'];
  }



}