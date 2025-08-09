import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/products_by_brand_remote_data_source.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/products_by_brand_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductsByBrandRepository)
class ProductsByBrandRepositoryImpl implements ProductsByBrandRepository {
  final ProductsByBrandRemoteDataSource remoteDataSource;

  ProductsByBrandRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<AllProductsEntity>> getProductsByBrandId(int brandId) {
    return remoteDataSource.getProductsByBrandId(brandId);
  }
}