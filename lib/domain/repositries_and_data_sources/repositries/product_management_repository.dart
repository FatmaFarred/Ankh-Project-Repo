// lib/domain/repositries_and_data_sources/product_management_repository.dart

import '../../entities/product_management_details_entity.dart';
import '../../entities/product_management_entity.dart';

abstract class ProductManagementRepository {
  Future<List<ProductManagementEntity>> getAllProducts();

  Future<ProductManagementDetailsEntity> getProductDetails(int id);

  Future<void> deleteProduct(int productId);
}
