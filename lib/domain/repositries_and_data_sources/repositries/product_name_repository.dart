import 'package:ankh_project/domain/entities/product_name_entity.dart';

abstract class ProductNameRepository {
  Future<List<ProductNameEntity>> getAllProductNames();
  Future<void> addProductName(String name);
  Future<void> deleteProductName(int id);
}