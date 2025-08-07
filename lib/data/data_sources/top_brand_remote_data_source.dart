import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:ankh_project/api_service/api_constants.dart';
import 'package:ankh_project/api_service/api_manager.dart';
import 'package:ankh_project/data/models/top_brand_model.dart';

/// Interface
abstract class TopBrandRemoteDataSource {
  Future<List<TopBrandModel>> fetchTopBrands();
  Future<bool> addTopBrand({required String name, required File imageFile});
  Future<bool> editTopBrand({required int id, required String name, required File? imageFile});
  Future<bool> deleteTopBrand({required int id});
}

/// Implementation with Injectable
@LazySingleton(as: TopBrandRemoteDataSource)
class TopBrandRemoteDataSourceImpl implements TopBrandRemoteDataSource {
  final http.Client client;
  final ApiManager apiManager;

  TopBrandRemoteDataSourceImpl({required this.client, required this.apiManager});

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

  @override
  Future<bool> addTopBrand({required String name, required File imageFile}) async {
    try {
      // Create form data
      final formData = FormData();
      
      // Add name field
      formData.fields.add(MapEntry('Name', name));
      
      // Add image file
      final fileName = imageFile.path.split('/').last;
      final multipartFile = await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      );
      formData.files.add(MapEntry('Image', multipartFile));
      
      // Make API call
      final response = await apiManager.postData(
        endPoint: 'TopBrand/add-brand',
        url: ApiConstant.baseUrl,
        data: formData,
      );
      
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw Exception('Failed to add top brand: $e');
    }
  }
  
  @override
  Future<bool> editTopBrand({required int id, required String name, required File? imageFile}) async {
    try {
      // Create form data
      final formData = FormData();
      
      // Add id and name fields
      formData.fields.add(MapEntry('Id', id.toString()));
      formData.fields.add(MapEntry('Name', name));
      
      // Add image file if provided
      if (imageFile != null) {
        final fileName = imageFile.path.split('/').last;
        final multipartFile = await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        );
        formData.files.add(MapEntry('Image', multipartFile));
      }
      
      // Make API call
      final response = await apiManager.putData(
        endPoint: 'TopBrand/edit-brand',
        url: ApiConstant.baseUrl,
        data: formData,
      );
      
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      throw Exception('Failed to edit top brand: $e');
    }
  }
  
  @override
  Future<bool> deleteTopBrand({required int id}) async {
    try {
      // Make API call
      final response = await apiManager.deleteData(
        endPoint: 'TopBrand/delete/$id',
        url: ApiConstant.baseUrl,
      );
      
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      throw Exception('Failed to delete top brand: $e');
    }
  }
}
