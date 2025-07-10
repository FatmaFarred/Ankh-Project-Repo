import 'package:ankh_project/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getPopularProducts();
  Future<List<ProductModel>> getRecommendedBrands();
}
