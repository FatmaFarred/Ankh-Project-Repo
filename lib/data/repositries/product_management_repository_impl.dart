import 'package:injectable/injectable.dart';

import '../../domain/repositries_and_data_sources/repositries/product_management_repository.dart';
import '../data_sources/product_management_remote_data_source.dart';
import '../../domain/entities/product_management_entity.dart';
import '../../domain/entities/product_management_details_entity.dart';

@LazySingleton(as: ProductManagementRepository)
class ProductManagementRepositoryImpl implements ProductManagementRepository {
  final ProductManagementRemoteDataSource remoteDataSource;

  ProductManagementRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProductManagementDetailsEntity> getProductDetails(int id) {
    return remoteDataSource.getProductDetails(id);
  }

  @override
  Future<List<ProductManagementEntity>> getAllProducts() {
    return remoteDataSource.getAllProducts();
  }

  @override
  Future<void> deleteProduct(int id) {
    return remoteDataSource.deleteProduct(id);
  }
}
