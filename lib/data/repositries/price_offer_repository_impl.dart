import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../../domain/entities/price_offer_request_entity.dart';
import '../../domain/repositries_and_data_sources/repositries/price_offer_repository.dart';
import '../models/price_offer_request_model.dart';

@LazySingleton(as: MarketerRequestRepository)
class PriceOfferRepositoryImpl implements MarketerRequestRepository {
  final http.Client client;

  PriceOfferRepositoryImpl(this.client);

  @override
  Future<Either<Failure, Unit>> sendPriceOfferRequest(PriceOfferRequestEntity request) async {
    final url = Uri.parse('https://ankhapi.runasp.net/api/RequestInspections/PriceOfferRequest');

    try {
      final model = PriceOfferRequestModel(
        marketerId: request.marketerId,
        productId: request.productId,
        clientName: request.clientName,
        clientPhone: request.clientPhone,
        requestedPrice: request.requestedPrice,
      );

      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(unit); // success
      } else {
        return left(Failure(errorMessage:'Request failed: ${response.statusCode} ${response.body}',  ));
      }
    } catch (e) {
      return left(Failure(errorMessage:'Exception: ${e.toString()}'));
    }
  }
}
