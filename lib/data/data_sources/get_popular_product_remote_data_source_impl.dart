import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ankh_project/data/models/product_model.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_remote_data_source.dart';

import '../../l10n/global_localization_helper.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final String baseUrl = 'https://ankhapi.runasp.net/';

  @override
  Future<List<ProductModel>> getPopularProducts() async {
    final response = await http.get(Uri.parse('${baseUrl}api/Home/popular'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception(GlobalLocalization.failedToLoadPopularProducts);
    }
  }

  @override
  Future<List<ProductModel>> getRecommendedBrands() async {
    final response = await http.get(Uri.parse('${baseUrl}api/Home/recommended'));

    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      return jsonData.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception(GlobalLocalization.failedToLoadRecommendedBrands);
    }
  }
}
