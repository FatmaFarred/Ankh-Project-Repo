import 'package:dio/dio.dart';
import '../models/price_offer_request_model.dart';

abstract class RemoteDataSource {
  Future<int> sendPriceOfferRequest(PriceOfferRequestModel request);
}
