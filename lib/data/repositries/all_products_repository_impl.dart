import 'package:injectable/injectable.dart';
import '../../../domain/entities/all_products_entity.dart';
import '../../../domain/repositries_and_data_sources/repositries/all_products_repository.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/all_products_remote_data_source.dart';
import '../data_sources/all_products_remote_data_source.dart';

@LazySingleton(as: AllProductsRepository)
class AllProductsRepositoryImpl implements AllProductsRepository {
  final AllProductsRemoteDataSource remoteDataSource;

  AllProductsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<AllProductsEntity>> getAllProducts() {
    return remoteDataSource.getAllProducts();
  }
}
