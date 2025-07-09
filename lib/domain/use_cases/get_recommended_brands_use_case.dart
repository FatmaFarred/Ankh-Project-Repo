import 'package:ankh_project/domain/entities/product_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/product_repository.dart';

class GetRecommendedBrandsUseCase{
  final ProductRepository repository;
  GetRecommendedBrandsUseCase(this.repository);
  Future<List<ProductEntity>> call(){
    return repository.getRecommendedBrands();
  }
}