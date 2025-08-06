import 'package:injectable/injectable.dart';
import 'package:ankh_project/data/data_sources/installment_offers_by_marketer_id_remote_data_source.dart';
import 'package:ankh_project/domain/entities/installment_offers_by_marketer_id_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/installment_offers_by_marketer_id_repository.dart';

@LazySingleton(as: InstallmentOffersByMarketerIdRepository)
class InstallmentOffersByMarketerIdRepositoryImpl
    implements InstallmentOffersByMarketerIdRepository {
  final InstallmentOffersByMarketerIdRemoteDataSource remoteDataSource;

  InstallmentOffersByMarketerIdRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<InstallmentOffersByMarketerIdEntity>> getAllOffers(String marketerId) async {
    print("Repository: Getting installment offers for marketer ID: $marketerId");
    try {
      final offers = await remoteDataSource.getAllOffers(marketerId);
      print("Repository: Retrieved ${offers.length} installment offers");
      return offers;
    } catch (e) {
      print("Repository: Error getting installment offers: $e");
      rethrow;
    }
  }
} 