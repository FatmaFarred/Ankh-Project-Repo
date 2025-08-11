import 'package:ankh_project/data/models/product_name_model.dart';

abstract class ProductNameRemoteDataSource {
  Future<List<ProductNameModel>> getAllProductNames();
  Future<void> addProductName(String name);
  Future<void> deleteProductName(int id);
}