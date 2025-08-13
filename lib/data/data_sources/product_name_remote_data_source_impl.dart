import 'dart:convert';
import 'package:ankh_project/api_service/api_constants.dart';
import 'package:ankh_project/data/models/product_name_model.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_name_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';

@LazySingleton(as: ProductNameRemoteDataSource)
class ProductNameRemoteDataSourceImpl implements ProductNameRemoteDataSource {
  final http.Client client;

  ProductNameRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductNameModel>> getAllProductNames() async {
    final response = await client.get(
      Uri.parse('https://ankhapi.runasp.net/api/Product/get-all-name'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((jsonItem) => ProductNameModel.fromJson(jsonItem))
          .toList();
    } else {
      throw Exception('Failed to load product names');
    }
  }

  @override
  Future<void> addProductName(String name) async {
    if (kDebugMode) {
      print('Adding product name: $name');
    }
    
    final response = await client.post(
      Uri.parse('https://ankhapi.runasp.net/api/Product/add-name'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (kDebugMode) {
        print('Product name added successfully');
      }
      return;
    } else {
      if (kDebugMode) {
        print('Failed to add product name: ${response.body}');
      }
      throw Exception('Failed to add product name: ${response.statusCode}');
    }
  }
  
  @override
  Future<void> deleteProductName(int id) async {
    if (kDebugMode) {
      print('Deleting product name with id: $id');
    }
    
    final response = await client.delete(
      Uri.parse('https://ankhapi.runasp.net/api/Product/delete-name?id=$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      if (kDebugMode) {
        print('Product name deleted successfully');
      }
      return;
    } else {
      if (kDebugMode) {
        print('Failed to delete product name: ${response.body}');
      }
      throw Exception('Failed to delete product name: ${response.statusCode}');
    }
  }
}