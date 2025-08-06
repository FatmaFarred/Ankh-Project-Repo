import 'package:injectable/injectable.dart';
import 'package:ankh_project/data/data_sources/price_offers_by_marketer_id_remote_data_source.dart';
import 'package:ankh_project/domain/entities/price_offers_by_marketer_id_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/price_offers_by_marketer_id_repository.dart';

@LazySingleton(as: PriceOffersByMarketerIdRepository)
class PriceOffersByMarketerIdRepositoryImpl
    implements PriceOffersByMarketerIdRepository {
  final PriceOffersByMarketerIdRemoteDataSource remoteDataSource;

  PriceOffersByMarketerIdRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PriceOffersByMarketerIdEntity>> getAllOffers(String marketerId) async {
    print("Repository: Getting offers for marketer ID: $marketerId");
    try {
      final offers = await remoteDataSource.getAllOffers(marketerId);
      print("Repository: Retrieved ${offers.length} offers");
      return offers;
    } catch (e) {
      print("Repository: Error getting offers: $e");
      rethrow;
    }
  }
}
