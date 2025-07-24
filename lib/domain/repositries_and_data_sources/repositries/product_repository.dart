import 'package:ankh_project/domain/entities/product_entity.dart';

abstract class ProductRepository{
  Future<List<ProductEntity>> getPopularProducts();
  Future<List<ProductEntity>> getRecommendedBrands();
}