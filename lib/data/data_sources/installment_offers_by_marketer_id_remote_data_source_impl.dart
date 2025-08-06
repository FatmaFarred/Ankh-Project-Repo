import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:ankh_project/data/models/installment_offers_by_marketer_id_model.dart';
import 'installment_offers_by_marketer_id_remote_data_source.dart';

@LazySingleton(as: InstallmentOffersByMarketerIdRemoteDataSource)
class InstallmentOffersByMarketerIdRemoteDataSourceImpl
    implements InstallmentOffersByMarketerIdRemoteDataSource {
  @override
  Future<List<InstallmentOffersByMarketerIdModel>> getAllOffers(String marketerId) async {
    final url = Uri.parse(
        'https://ankhapi.runasp.net/api/RequestInspections/installments-by-marketerid/$marketerId');

    print("Fetching installment offers from URL: $url");
    final response = await http.get(url);

    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      print("Parsed data length: ${data.length}");
      final offers = data
          .map((json) => InstallmentOffersByMarketerIdModel.fromJson(json))
          .toList();
      print("Created ${offers.length} installment offers");
      return offers;
    } else {
      print("Error response: ${response.body}");
      throw Exception('Failed to fetch installment offers: ${response.statusCode}');
    }
  }
} 