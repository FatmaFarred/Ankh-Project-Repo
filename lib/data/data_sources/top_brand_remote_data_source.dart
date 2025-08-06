import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:ankh_project/data/models/top_brand_model.dart';

/// Interface
abstract class TopBrandRemoteDataSource {
  Future<List<TopBrandModel>> fetchTopBrands();
}

/// Implementation with Injectable
@LazySingleton(as: TopBrandRemoteDataSource)
class TopBrandRemoteDataSourceImpl implements TopBrandRemoteDataSource {
  final http.Client client;

  TopBrandRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TopBrandModel>> fetchTopBrands() async {
    final response = await client.get(
      Uri.parse('https://ankhapi.runasp.net/api/TopBrand/get-all'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TopBrandModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top brands');
    }
  }
}
