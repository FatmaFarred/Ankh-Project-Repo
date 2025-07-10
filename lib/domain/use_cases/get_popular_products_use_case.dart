import 'package:ankh_project/domain/entities/product_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/product_repository.dart';

class GetPopularProductsUseCase{
  final ProductRepository repository;
  GetPopularProductsUseCase(this.repository);

  Future<List<ProductEntity>> call() {
    return repository.getPopularProducts();
  }
}