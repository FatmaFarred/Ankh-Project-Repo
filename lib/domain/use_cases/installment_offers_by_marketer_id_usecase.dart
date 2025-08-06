import 'package:ankh_project/domain/entities/installment_offers_by_marketer_id_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/installment_offers_by_marketer_id_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetInstallmentOffersByMarketerIdUseCase {
  final InstallmentOffersByMarketerIdRepository repository;

  GetInstallmentOffersByMarketerIdUseCase(this.repository);

  Future<List<InstallmentOffersByMarketerIdEntity>> call(String marketerId) async {
    print("UseCase: Getting installment offers for marketer ID: $marketerId");
    try {
      final offers = await repository.getAllOffers(marketerId);
      print("UseCase: Retrieved ${offers.length} installment offers");
      return offers;
    } catch (e) {
      print("UseCase: Error getting installment offers: $e");
      rethrow;
    }
  }
} 