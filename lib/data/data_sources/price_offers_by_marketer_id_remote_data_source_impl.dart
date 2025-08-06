import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:ankh_project/data/models/price_offers_by_marketer_id_model.dart';
import 'price_offers_by_marketer_id_remote_data_source.dart';

@LazySingleton(as: PriceOffersByMarketerIdRemoteDataSource)
class PriceOffersByMarketerIdRemoteDataSourceImpl
    implements PriceOffersByMarketerIdRemoteDataSource {
  @override
  Future<List<PriceOffersByMarketerIdModel>> getAllOffers(String marketerId) async {
    final url = Uri.parse(
        'https://ankhapi.runasp.net/api/RequestInspections/alloffer-by-marketerid/$marketerId');

    print("Fetching offers from URL: $url");
    final response = await http.get(url);

    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      print("Parsed data length: ${data.length}");
      final offers = data
          .map((json) => PriceOffersByMarketerIdModel.fromJson(json))
          .toList();
      print("Created ${offers.length} offers");
      return offers;
    } else {
      print("Error response: ${response.body}");
      throw Exception('Failed to fetch price offers: ${response.statusCode}');
    }
  }
}
