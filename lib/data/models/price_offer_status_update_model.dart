// lib/data/models/price_offer_status_update_model.dart
import 'package:ankh_project/domain/entities/price_offer_status_update_entity.dart';

class PriceOfferStatusUpdateModel extends PriceOfferStatusUpdateEntity {
  const PriceOfferStatusUpdateModel({
    required super.status,
    required super.adminNote,
  });

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "adminNote": adminNote,
    };
  }

  factory PriceOfferStatusUpdateModel.fromEntity(PriceOfferStatusUpdateEntity entity) {
    return PriceOfferStatusUpdateModel(
      status: entity.status,
      adminNote: entity.adminNote,
    );
  }
}
