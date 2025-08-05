// lib/domain/use_cases/update_price_offer_status_usecase.dart
import 'package:injectable/injectable.dart';

import '../entities/price_offer_status_update_entity.dart';
import '../repositries_and_data_sources/repositries/get_all_price_offer_repository.dart';

@injectable
class UpdatePriceOfferStatusUseCase {
  final PriceOfferRepository repository;

  UpdatePriceOfferStatusUseCase(this.repository);

  Future<void> call(String id, PriceOfferStatusUpdateEntity entity) {
    return repository.updatePriceOfferStatus(id, entity);
  }
}

