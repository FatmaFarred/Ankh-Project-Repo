import 'dart:convert';
import 'package:ankh_project/data/models/product_management_model.dart';
import 'package:ankh_project/data/models/product_management_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class ProductManagementRemoteDataSource {
  Future<List<ProductManagementModel>> getAllProducts();
  Future<ProductManagementDetailsModel> getProductDetails(int id);
  Future<void> deleteProduct(int id);
}

@LazySingleton(as: ProductManagementRemoteDataSource)
class ProductManagementRemoteDataSourceImpl
    implements ProductManagementRemoteDataSource {
  final http.Client client;

  ProductManagementRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductManagementModel>> getAllProducts() async {
    final response = await client.get(
      Uri.parse('https://ankhapi.runasp.net/api/Product'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((jsonItem) => ProductManagementModel.fromJson(jsonItem))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

    @override
    Future<ProductManagementDetailsModel> getProductDetails(int id) async {
      final response = await client.get(
        Uri.parse('https://ankhapi.runasp.net/api/Product/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        print('🔍 Full API Response: ${response.body}');
        return ProductManagementDetailsModel.fromJson(decoded);
      } else {
        throw Exception('Failed to load product details');
      }
    }

  @override
  Future<void> deleteProduct(int productId) async {
    final uri = Uri.parse('https://ankhapi.runasp.net/api/Product/$productId');

    final response = await client.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete product');
    }
  }
}
