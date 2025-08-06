import 'package:ankh_project/domain/entities/price_offers_by_marketer_id_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/price_offers_by_marketer_id_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPriceOffersByMarketerIdUseCase {
  final PriceOffersByMarketerIdRepository repository;

  GetPriceOffersByMarketerIdUseCase(this.repository);

  Future<List<PriceOffersByMarketerIdEntity>> call(String marketerId) async {
    print("UseCase: Getting offers for marketer ID: $marketerId");
    try {
      final offers = await repository.getAllOffers(marketerId);
      print("UseCase: Retrieved ${offers.length} offers");
      return offers;
    } catch (e) {
      print("UseCase: Error getting offers: $e");
      rethrow;
    }
  }
}
