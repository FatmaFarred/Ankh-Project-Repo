import 'package:ankh_project/data/models/all_products_dm.dart';

abstract class ProductsByBrandRemoteDataSource {
  Future<List<AllProductsDm>> getProductsByBrandId(int brandId);
}