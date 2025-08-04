import 'package:dartz/dartz.dart';
import '../../../api_service/failure/error_handling.dart';
import '../../entities/price_offer_request_entity.dart';

abstract class MarketerRequestRepository {
  Future<Either<Failure, Unit>> sendPriceOfferRequest(PriceOfferRequestEntity request);
}
