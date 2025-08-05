import '../entities/price_offer_pending_entity.dart';
import '../repositries_and_data_sources/repositries/get_all_price_offer_repository.dart';
import '../repositries_and_data_sources/repositries/price_offer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPendingPriceOffersUseCase {
  final PriceOfferRepository repository;

  GetPendingPriceOffersUseCase(this.repository);

  Future<List<PriceOfferPendingEntity>> call() {
    return repository.getPendingPriceOffers();
  }
}
