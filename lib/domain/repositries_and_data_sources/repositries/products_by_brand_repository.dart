import 'package:ankh_project/domain/entities/all_products_entity.dart';

abstract class ProductsByBrandRepository {
  Future<List<AllProductsEntity>> getProductsByBrandId(int brandId);
}