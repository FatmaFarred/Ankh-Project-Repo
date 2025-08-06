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
}
