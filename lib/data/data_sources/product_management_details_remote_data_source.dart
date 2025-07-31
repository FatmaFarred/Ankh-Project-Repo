import 'package:dio/dio.dart';
import '../models/product_management_details_model.dart';

class ProductManagementRemoteDataSource {
  final Dio dio;

  ProductManagementRemoteDataSource(this.dio);

  Future<ProductManagementDetailsModel> getProductDetails(int id) async {
    final response = await dio.get('https://ankhapi.runasp.net/api/Product/$id');
    return ProductManagementDetailsModel.fromJson(response.data);
  }
}
