// lib/data/data_sources/price_offer_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../models/price_offer_pending_model.dart';
import '../models/price_offer_status_update_model.dart';

abstract class PriceOfferRemoteDataSource {
  Future<List<PriceOfferPendingModel>> getPendingPriceOffers();
  Future<void> updatePriceOfferStatus(String id, PriceOfferStatusUpdateModel model);

}

@LazySingleton(as: PriceOfferRemoteDataSource)
class PriceOfferRemoteDataSourceImpl implements PriceOfferRemoteDataSource {
  @override
  Future<List<PriceOfferPendingModel>> getPendingPriceOffers() async {
    final response = await http.get(
      Uri.parse("https://ankhapi.runasp.net/api/RequestInspections/price-offers-pending"),
    );

    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded
          .map((json) => PriceOfferPendingModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch pending price offers');
    }
  }

  @override
  Future<void> updatePriceOfferStatus(String id, PriceOfferStatusUpdateModel model) async {
    final response = await http.post(
      Uri.parse("https://ankhapi.runasp.net/api/RequestInspections/price-offers/$id/process"),
      body: json.encode(model.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to update price offer status');
    }
  }

}
