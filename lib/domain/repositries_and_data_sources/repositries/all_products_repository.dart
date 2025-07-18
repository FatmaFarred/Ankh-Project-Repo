import 'package:ankh_project/domain/entities/all_products_entity.dart';

abstract class AllProductsRepository {
  Future<List<AllProductsEntity>> getAllProducts();
}