import 'package:ankh_project/domain/entities/price_offer_status_update_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/price_offer_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/price_offer_pending_entity.dart';
import '../../domain/repositries_and_data_sources/repositries/get_all_price_offer_repository.dart';
import '../data_sources/price_offer_remote_data_source.dart';
import '../models/price_offer_status_update_model.dart';

@LazySingleton(as: PriceOfferRepository)
class PriceOfferRepositoryImpl implements PriceOfferRepository {
  final PriceOfferRemoteDataSource remoteDataSource;

  PriceOfferRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PriceOfferPendingEntity>> getPendingPriceOffers() {
    return remoteDataSource.getPendingPriceOffers();
  }

  @override
  Future<void> updatePriceOfferStatus(String id, PriceOfferStatusUpdateEntity entity) {
    final model = PriceOfferStatusUpdateModel.fromEntity(entity);
    return remoteDataSource.updatePriceOfferStatus(id, model);
  }
}
