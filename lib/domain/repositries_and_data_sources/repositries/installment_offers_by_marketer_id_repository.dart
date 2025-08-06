import 'package:ankh_project/domain/entities/installment_offers_by_marketer_id_entity.dart';

abstract class InstallmentOffersByMarketerIdRepository {
  Future<List<InstallmentOffersByMarketerIdEntity>> getAllOffers(String marketerId);
} 