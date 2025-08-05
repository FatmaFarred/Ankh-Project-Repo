import '../../entities/price_offer_pending_entity.dart';
import '../../entities/price_offer_status_update_entity.dart';

abstract class PriceOfferRepository {
  Future<List<PriceOfferPendingEntity>> getPendingPriceOffers();

  Future<void> updatePriceOfferStatus(
    String id,
    PriceOfferStatusUpdateEntity entity,
  );
}
