import 'package:injectable/injectable.dart';

import '../entities/top_brand_entity.dart';
import '../repositries_and_data_sources/repositries/top_brand_repository.dart';

@lazySingleton
class GetTopBrandsUseCase {
  final TopBrandRepository repository;

  GetTopBrandsUseCase(this.repository);

  Future<List<TopBrandEntity>> call() async {
    return await repository.getTopBrands();
  }
}
