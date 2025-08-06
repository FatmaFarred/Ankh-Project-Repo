import 'package:ankh_project/domain/entities/price_offers_by_marketer_id_entity.dart';

abstract class PriceOffersByMarketerIdRepository {
  Future<List<PriceOffersByMarketerIdEntity>> getAllOffers(String marketerId);
}
