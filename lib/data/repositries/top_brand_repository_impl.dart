import 'dart:io';
import 'package:injectable/injectable.dart';

import '../../domain/entities/top_brand_entity.dart';
import '../../domain/repositries_and_data_sources/repositries/top_brand_repository.dart';
import '../data_sources/top_brand_remote_data_source.dart';

@LazySingleton(as: TopBrandRepository)
class TopBrandRepositoryImpl implements TopBrandRepository {
  final TopBrandRemoteDataSource remoteDataSource;

  TopBrandRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<TopBrandEntity>> getTopBrands() async {
    return await remoteDataSource.fetchTopBrands();
  }

  @override
  Future<bool> addTopBrand({required String name, required File imageFile}) async {
    return await remoteDataSource.addTopBrand(name: name, imageFile: imageFile);
  }
  
  @override
  Future<bool> editTopBrand({required int id, required String name, required File? imageFile}) async {
    return await remoteDataSource.editTopBrand(id: id, name: name, imageFile: imageFile);
  }
  
  @override
  Future<bool> deleteTopBrand({required int id}) async {
    return await remoteDataSource.deleteTopBrand(id: id);
  }
}
