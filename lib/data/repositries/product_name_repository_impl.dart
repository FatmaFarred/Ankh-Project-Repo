import 'package:ankh_project/domain/entities/product_name_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_name_remote_data_source.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/product_name_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductNameRepository)
class ProductNameRepositoryImpl implements ProductNameRepository {
  final ProductNameRemoteDataSource remoteDataSource;

  ProductNameRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductNameEntity>> getAllProductNames() async {
    return await remoteDataSource.getAllProductNames();
  }

  @override
  Future<void> addProductName(String name) async {
    await remoteDataSource.addProductName(name);
  }
  
  @override
  Future<void> deleteProductName(int id) async {
    await remoteDataSource.deleteProductName(id);
  }
}