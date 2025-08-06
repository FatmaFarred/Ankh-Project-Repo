import 'package:ankh_project/data/models/installment_offers_by_marketer_id_model.dart';

abstract class InstallmentOffersByMarketerIdRemoteDataSource {
  Future<List<InstallmentOffersByMarketerIdModel>> getAllOffers(String marketerId);
} 