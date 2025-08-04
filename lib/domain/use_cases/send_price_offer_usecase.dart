import 'package:dartz/dartz.dart';
import '../../api_service/failure/error_handling.dart';
import '../entities/price_offer_request_entity.dart';
import 'package:injectable/injectable.dart';

import '../repositries_and_data_sources/repositries/price_offer_repository.dart';

@injectable
class SendPriceOfferUseCase {
  final MarketerRequestRepository repository;

  SendPriceOfferUseCase(this.repository);

  Future<Either<Failure, Unit>> call(PriceOfferRequestEntity request) {
    return repository.sendPriceOfferRequest(request);
  }
}
