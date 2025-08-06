import 'package:ankh_project/data/models/price_offers_by_marketer_id_model.dart';

abstract class PriceOffersByMarketerIdRemoteDataSource {
  Future<List<PriceOffersByMarketerIdModel>> getAllOffers(String marketerId);
}
