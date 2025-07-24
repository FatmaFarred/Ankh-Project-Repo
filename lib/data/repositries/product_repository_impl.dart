import 'package:ankh_project/domain/repositries_and_data_sources/repositries/product_repository.dart';
import 'package:ankh_project/data/models/product_model.dart';
import 'package:ankh_project/domain/entities/product_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductEntity>> getPopularProducts() async {
    final models = await remoteDataSource.getPopularProducts();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<ProductEntity>> getRecommendedBrands() async {
    final models = await remoteDataSource.getRecommendedBrands();
    return models.map((model) => model.toEntity()).toList();
  }
}
